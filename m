Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWDBQGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWDBQGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWDBQGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:06:07 -0400
Received: from rtr.ca ([64.26.128.89]:50606 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751481AbWDBQGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:06:06 -0400
Message-ID: <442FF65A.6020209@rtr.ca>
Date: Sun, 02 Apr 2006 12:05:46 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
References: <20060402155647.GB20270@localdomain>
In-Reply-To: <20060402155647.GB20270@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> Hello,
> 
> I'm testing the sata_mv driver to see whether reloading (rmmod 
> - insmod) works, and it seems something is broken there. The
> first insmod goes okay - however all the insmods that follow
> emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady 
> SeekComplete } from all the drives.
> 
> I've enabled DPRINTK and fixed a crash involved with register
> dumping (posted in my previous mail).
> 
> I hope these messages are sufficient, I can provide more 
> information if needed.

What kernel?  Any patches applied to sata_mv.c ??
