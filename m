Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWDOQlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWDOQlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWDOQlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 12:41:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:34204 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030288AbWDOQlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 12:41:51 -0400
Message-ID: <4441224C.5010905@garzik.org>
Date: Sat, 15 Apr 2006 12:41:48 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Esben Stien <b0ef@esben-stien.name>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA Conflict with PATA DMA
References: <87odz2kc0k.fsf@esben-stien.name>
In-Reply-To: <87odz2kc0k.fsf@esben-stien.name>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Stien wrote:
> I'm having problems enabling DMA for my PATA HD.
> 
> hdparm -d1 /dev/hdb reports: 
> HDIO_SET_DMA failed: Operation not permitted
> 
> Of course, I'm super user. Nothing is printed in dmesg. 
> 
> I'm on linux-2.6.16 and motherboard is Fujitsu Siemens D1561 with an
> ICH5. I also have a SATA hd in the computer and this only happens when
> the SATA hd is there. If I remove the SATA HD, then I can enable DMA
> for the PATA hd.

Disabled combined mode in BIOS.

	Jeff



