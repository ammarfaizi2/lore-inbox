Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTGKTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbTGKTxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:53:46 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29709 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265144AbTGKTxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:53:16 -0400
Date: Fri, 11 Jul 2003 22:07:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711200755.GA20970@win.tue.nl>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
> >   are no longer supported. The only way forward is to remove the translator
> >   from the drive, and start over.
> 
> Or to use device mapper to remap the disk.

Or to use boot parameters:
 * "hdx=remap63"        : add 63 to all sector numbers (for OnTrack DM)
 * "hdx=remap"          : remap 0->1 (for EZDrive)

(So, I think the language "no longer supported" is a bit strong.
Maybe "no longer autodetected".)

Andries

