Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSFDPgj>; Tue, 4 Jun 2002 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSFDPgi>; Tue, 4 Jun 2002 11:36:38 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53674 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S314101AbSFDPgg>; Tue, 4 Jun 2002 11:36:36 -0400
Date: Tue, 4 Jun 2002 17:36:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kjeld Borch Egevang <kjelde@mips.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sys_time() not working on 64-bit processor
In-Reply-To: <Pine.LNX.4.44.0206041356400.7022-100000@coplin19.mips.com>
Message-ID: <Pine.GSO.3.96.1020604173540.17556G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Kjeld Borch Egevang wrote:

> I'm currently running on a 64-bit version of Linux on a MIPS processor
> (int == 32 bit, long == 64 bit). I noticed that the time() system call did
> not work.
> 
> Is there any reason why sys_time() (and sys_stime()) in kernel/time.c is
> defined with an int pointer?

 The syscalls are obsolete and do not even attempt to work on 64-bit
systems.  It's all explained there.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

