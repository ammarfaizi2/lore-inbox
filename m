Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTD3KFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTD3KFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:05:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:64130 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261707AbTD3KFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:05:46 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304301021.h3UALumk000956@81-2-122-30.bradfords.org.uk>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop - Kernel bug?
To: dusty@violin.dyndns.org (Hermann Himmelbauer)
Date: Wed, 30 Apr 2003 11:21:56 +0100 (BST)
Cc: nuno.silva@vgertech.com (Nuno Silva),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <200304301155.11319.dusty@violin.dyndns.org> from "Hermann Himmelbauer" at Apr 30, 2003 11:55:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thursday 10 April 2003 04:53, Nuno Silva wrote:
> > Hello!
> >
> > Hermann Himmelbauer wrote:
> > > Well - anyway, the kernel boots but right stops after:
> > > INIT: Entering runlevel:3
> > >
> > > The next line is:
> > > INIT: open(/dev/console): Input/output error
> > > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > > ...
> > >
> > > That's it.
> >
> > Maybe you striped too much and didn't include *any* console type
> > (serial, vga or framebuffer)? :)
> 
> Well - by chance we found another old Laptop, an IBM Thinkpad 350 (the old was 
> model 340) and found a RAM extension, so we have no 36MB RAM.
> 
> But - guess what: The error still persists!
> 
> I am quite clueless - maybe it has something to do with the IDE subsystem? We 
> put a 4GB 2.5'' HD in this old Laptop, but the harddisk is correctly 
> recognized by Linux (also Partition check), grub is also working and it Linux 
> also mounts the partition.
> 
> Is there any way to get more information out of the kernel?

What happens if you with with init set to be a shell?  E.G. init=/bin/bash

John.
