Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTGKUYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbTGKUYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:24:48 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:62219 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266767AbTGKUYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:24:09 -0400
Date: Fri, 11 Jul 2003 22:38:50 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711203850.GB20970@win.tue.nl>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <20030711155613.GC2210@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711155613.GC2210@gtf.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 11:56:13AM -0400, Jeff Garzik wrote:

> Definitely.  I'm hoping that people will decide upon a userland that
> supports the popular (non-raid) partition tables as well as the simple
> raid partitions, too.

That reminds me.

Our DOS-type partition tables are close to their limit -
regularly people complain about things that do not work
with disks of size between 1 TB and 2 TB, and if not today
then very soon we'll see disks too large to handle with
DOS-type partition tables.

Two years ago or so I wrote some simple-minded stuff -
maybe there also was discussion on Linux-type partition tables,
I forgot all about it.
(Maybe the format was plan9-inspired, with sequence number,
start, size, label and uuid, all in ASCII.)

What is the situation today? What is the structure of these
LVM or raid partition tables? Is there some natural type
suitable for crossing the 2 TB limit?
Is it better to invent a Linux-type partition table?

Andries

