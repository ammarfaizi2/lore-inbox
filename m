Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSLUR5R>; Sat, 21 Dec 2002 12:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLUR5R>; Sat, 21 Dec 2002 12:57:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:58628 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262887AbSLUR5P>;
	Sat, 21 Dec 2002 12:57:15 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212211816.gBLIG3NV000880@darkstar.example.net>
Subject: Re: How to help new comers trying the v2.5x series kernels.
To: sampson.fung@attglobal.net (Sampson Fung)
Date: Sat, 21 Dec 2002 18:16:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c2a91a$707254a0$0100a8c0@noelpc> from "Sampson Fung" at Dec 22, 2002 01:57:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From v2.5.49 up, I can only test the compiled kernel, if it compiles at
> all, with modules disabled completely.
> Of course, I have to say that I do not try much before v2.5.49.
> 
> I think new comers, myselft included, can make use of standard templates
> of kernel .config file.

Try a minimal configuration, or the default one, (which is whatever
Linus uses).  Avoid modular IDE for now.

> First of all, "standard templates" are tested that they will be compiled
> without problem.
> They should be able to boot.
> They should have a working "framework" of "modules", for example, lsmod
> works without any problem.  (And any other "required" modutils as well)
> They shuold supports further kernel compile. (With small incremental
> changes to the base "standard template").

Sounds like an excellent job for a new kernel hacker to take on board
- why not make the standard templates yourself, and post them to the
list for each 2.5.x tree.  It *would* be quite useful, and save a lot
of developers' time, for example, it would stop a lot of people
complaining about modular IDE.

> Then I can try to compile my lan card as modules.
> Then try to compile my SCSI card, etc, etc.
> 
> Does similar "standard templates" exist already?  

No.

> Where can I search for known bugs centrally, so that I can help myself
> as much as possible?

* The mailing list archives
* Kernel Bugzilla
* (hopefully in a week or so) my new bug database which I am currently
  writing.

John.
