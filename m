Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbTGLPYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbTGLPYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:24:11 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54931 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266033AbTGLPXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:23:44 -0400
Date: Sat, 12 Jul 2003 16:38:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712153818.GA9547@mail.jlokier.co.uk>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <20030711155613.GC2210@gtf.org> <20030711203850.GB20970@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711203850.GB20970@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> > Definitely.  I'm hoping that people will decide upon a userland that
> > supports the popular (non-raid) partition tables as well as the simple
> > raid partitions, too.
> 
> That reminds me.
> 
> Our DOS-type partition tables are close to their limit -
> regularly people complain about things that do not work
> with disks of size between 1 TB and 2 TB, and if not today
> then very soon we'll see disks too large to handle with
> DOS-type partition tables.
> 
> Two years ago or so I wrote some simple-minded stuff -
> maybe there also was discussion on Linux-type partition tables,
> I forgot all about it.
> (Maybe the format was plan9-inspired, with sequence number,
> start, size, label and uuid, all in ASCII.)
> 
> What is the situation today? What is the structure of these
> LVM or raid partition tables? Is there some natural type
> suitable for crossing the 2 TB limit?
> Is it better to invent a Linux-type partition table?

What are the limits of the "Windows Logical Disk Manager (LDM)"
partition format?  I've never used it myself, but it's there in
fs/partitions and presumably there are people using it on modern PCs.

-- Jamie
