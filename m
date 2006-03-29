Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWC2Rhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWC2Rhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWC2Rhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:37:31 -0500
Received: from rtr.ca ([64.26.128.89]:65254 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750893AbWC2Rhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:37:31 -0500
Message-ID: <442AC5D2.2080209@rtr.ca>
Date: Wed, 29 Mar 2006 12:37:22 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
Cc: Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net, dror@xiv.co.il
Subject: Re: [PATCH 2.6.16] sata_mv.c :: three bug fixes
References: <200603290950.32219.lkml@rtr.ca> <20060329170628.GA25640@localdomain>
In-Reply-To: <20060329170628.GA25640@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:

> The original code checks ap for NULL, are you sure it is safe to
> remove this?

"ap" is used above in the same function, long before the check for NULL,
so the checks lower down are worthless.

Cheers

