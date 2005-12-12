Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVLLEfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVLLEfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLLEfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:35:48 -0500
Received: from rtr.ca ([64.26.128.89]:58801 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751095AbVLLEfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:35:47 -0500
Message-ID: <439CFE22.7080502@rtr.ca>
Date: Sun, 11 Dec 2005 23:35:46 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sata_via VT6421 vendor update
References: <439CF781.3080400@pobox.com>
In-Reply-To: <439CF781.3080400@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> VIA contributed the attached update to sata_via, which adds support for 
> the third (PATA) port, and switches around the reset method a bit.

Too many inline busy-waits.. needs to use timers & callbacks instead.
But it might do in the interim, until that stuff gets fixed.

Cheers
