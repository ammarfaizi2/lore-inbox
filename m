Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbTBMX0y>; Thu, 13 Feb 2003 18:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbTBMX0y>; Thu, 13 Feb 2003 18:26:54 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:9441 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S268323AbTBMX0x>;
	Thu, 13 Feb 2003 18:26:53 -0500
Date: Fri, 14 Feb 2003 00:36:42 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Valdis.Kletnieks@vt.edu
Cc: Bruno Diniz de Paula <diniz@cs.rutgers.edu>, linux-kernel@vger.kernel.org
Subject: Re: How to bypass buffer caches?
Message-ID: <20030213233642.GA4900@win.tue.nl>
References: <1045157351.21195.134.camel@urca.rutgers.edu> <200302131737.h1DHbIFT007308@turing-police.cc.vt.edu> <1045158671.4767.138.camel@urca.rutgers.edu> <200302131820.h1DIKfFT007758@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302131820.h1DIKfFT007758@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 13 Feb 2003 12:51:19 EST, Bruno Diniz de Paula said:
> 
> > But what if "/dev/hda7" already has an ext2 fs set up. How am I supposed
> > to know which phisical blocks in the disk correspond to each of my files
> > in the ext2 mapping, that is, "/var/somefile" or "/usr/local/otherfile"?
> 
> The quick answer:  Don't do that. ;)

But if you insist, there is the FIBMAP ioctl.
