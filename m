Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317635AbSFRVzC>; Tue, 18 Jun 2002 17:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSFRVzB>; Tue, 18 Jun 2002 17:55:01 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:10161 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S317635AbSFRVzA>; Tue, 18 Jun 2002 17:55:00 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Various kbuild problems in 2.5.22
Date: 18 Jun 2002 21:23:55 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnagv97b.1r4.kraxel@bytesex.org>
References: <200206181500.IAA00339@baldur.yggdrasil.com> <Pine.LNX.4.44.0206181056090.5695-100000@chaos.physics.uiowa.edu>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1024435435 1893 127.0.0.1 (18 Jun 2002 21:23:55 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Apart from that, "make modules_install" never worked in the case of 
>  failed builds, did it? - so it boils down to: you need a buildable .config 
>  to build and test a kernel.

No.  2.4.x allows me to to "make modules_install" even if some modules
don't work.  My kernel build script compiles the modules with "make -k
modules", and if some non-essential modules doesn't build I can simply
ignore that and go ahead.  There is no need to disable that module
temporarely in .config (and risc to forget to reenable it later ...).

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
