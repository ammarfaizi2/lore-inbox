Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161750AbWKHXun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161750AbWKHXun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161751AbWKHXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:50:43 -0500
Received: from rtr.ca ([64.26.128.89]:5393 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161750AbWKHXum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:50:42 -0500
Message-ID: <45526D50.5020105@rtr.ca>
Date: Wed, 08 Nov 2006 18:50:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us>
In-Reply-To: <455206E7.2050104@seclark.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the drivers/ide stuff from you system and let libata (ata_piix)
manage the ICH7.  That should speed things up quite a bit.

-ml
