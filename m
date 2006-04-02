Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWDBQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWDBQNb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWDBQNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:13:31 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:13166 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932376AbWDBQNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:13:30 -0400
Date: Sun, 2 Apr 2006 19:14:49 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
Message-ID: <20060402161449.GA21822@localdomain>
References: <20060402155647.GB20270@localdomain> <442FF65A.6020209@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442FF65A.6020209@rtr.ca>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 12:05:46PM -0400, Mark Lord wrote:
> Dan Aloni wrote:
> >Hello,
> >
> >I'm testing the sata_mv driver to see whether reloading (rmmod 
> >- insmod) works, and it seems something is broken there. The
> >first insmod goes okay - however all the insmods that follow
> >emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady 
> >SeekComplete } from all the drives.
> >
> >I've enabled DPRINTK and fixed a crash involved with register
> >dumping (posted in my previous mail).
> >
> >I hope these messages are sufficient, I can provide more 
> >information if needed.
> 
> What kernel?  Any patches applied to sata_mv.c ??
> 

2.6.16 + ncq branch. sata_mv.c was modified by me - I'll retry
with a cleaner configuration, sorry.

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
