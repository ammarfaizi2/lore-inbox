Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTDMQCK (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 12:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTDMQCK (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 12:02:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:47232 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263540AbTDMQCJ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 12:02:09 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304131615.h3DGFp7t000811@81-2-122-30.bradfords.org.uk>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 13 Apr 2003 17:15:51 +0100 (BST)
Cc: tmiller10@cfl.rr.com (Timothy Miller),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1050244174.24187.15.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 13, 2003 03:29:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, what if one were to write a program which would perform a bunch of
> > seek-time tests to estimate an IDE disk's physical geometry?  It could then
> > make that information available to the kernel to use to reorder accesses
> > more optimally.
> 
> Its a common misconception that a disk looks something like it did 15
> years ago. Your ATA disk is basically an entire standalone computer 
> running a small OS. The physical disk layout does not divide neatly 
> into equal sized cylinders and some blocks may even be in suprising
> places due to bad block sparing or anything else the drive manufacturer
> felt appropriate.

Is the basic assumption that lower block numbers are generally located
in zones nearer the outside of the disk still true, though?  I.E. do
you know of any disks that 'start from the middle'?  I usually
recommend that people place their swap and /var partitions near the
beginning of the disk, (for a _slight_ improvement), but maybe there
is a good reason not to do this for some disks?

John.
