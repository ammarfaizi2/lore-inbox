Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWFSO2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWFSO2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWFSO2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:28:12 -0400
Received: from rtr.ca ([64.26.128.89]:26600 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932452AbWFSO2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:28:12 -0400
Message-ID: <4496B47B.7070602@rtr.ca>
Date: Mon, 19 Jun 2006 10:28:11 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Narendra Hadke <nhadke@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_mv driver on 88sx6041 (kernel version 2.6.13)
References: <20060616164827.18258.qmail@web33514.mail.mud.yahoo.com>
In-Reply-To: <20060616164827.18258.qmail@web33514.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narendra Hadke wrote:
> Hi,
> I am using sata_mv driver as exists in kernel 2.6.13,
> reached to a stage where after detecting the disk,
> control gets struck. Any ideas? 

No surprises there.  The sata_mv driver is horribly buggy
in all kernels prior to 2.6.16, and even there it still has
some serious bugs.  The 2.6.17 kernel version is MUCH better.

Cheers
