Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSLUS4o>; Sat, 21 Dec 2002 13:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSLUS4o>; Sat, 21 Dec 2002 13:56:44 -0500
Received: from [81.2.122.30] ([81.2.122.30]:773 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S263291AbSLUS4m>;
	Sat, 21 Dec 2002 13:56:42 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212211915.gBLJFaZb001636@darkstar.example.net>
Subject: Re: How to help new comers trying the v2.5x series kernels.
To: sampson@attglobal.net (Sampson Fung)
Date: Sat, 21 Dec 2002 19:15:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000b01c2a91f$01324ff0$0100a8c0@noelpc> from "Sampson Fung" at Dec 22, 2002 02:30:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I think new comers, myselft included, can make use of standard 
> > > templates of kernel .config file.
> > 
> > Try a minimal configuration, or the default one, (which is 
> > whatever Linus uses).  Avoid modular IDE for now.
> > 
> Where is the default .config?  I am eager to have a try.

Just do:

make distclean; make defconfig

and the default .config will be generated.

> > > First of all, "standard templates" are tested that they will be 
> > > compiled without problem. They should be able to boot.
> > > They should have a working "framework" of "modules", for 
> > > example, lsmod works without any problem.  (And any other
> > > "required" modutils as well)
> > > They shuold supports further kernel compile. (With small incremental
> > > changes to the base "standard template").
> > 
> > Sounds like an excellent job for a new kernel hacker to take on board
> > - why not make the standard templates yourself, and post them 
> > to the list for each 2.5.x tree.  It *would* be quite useful, 
> > and save a lot of developers' time, for example, it would 
> > stop a lot of people complaining about modular IDE.
> 
> I can post my config as I am using common hardware config.
> But I cannot make the "framework" of "modules" working for me.

Don't worry about the hardware options - just assume that the ones in
defconfig work OK - but try to successfully build as many features
like different filesystems, etc.

John.
