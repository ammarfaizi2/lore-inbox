Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRL1Pt4>; Fri, 28 Dec 2001 10:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286925AbRL1Ptq>; Fri, 28 Dec 2001 10:49:46 -0500
Received: from mons.uio.no ([129.240.130.14]:62946 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S286922AbRL1Ptg>;
	Fri, 28 Dec 2001 10:49:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15404.37994.476173.804713@charged.uio.no>
Date: Fri, 28 Dec 2001 16:48:58 +0100
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
        Amber Palekar <amber_palekar@yahoo.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Again:syscall from modules
In-Reply-To: <20011228134106.B1323@dea.linux-mips.net>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com>
	<1009468465.15846.0.camel@eggis1>
	<15403.28458.153083.961800@charged.uio.no>
	<20011228134106.B1323@dea.linux-mips.net>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ralf Baechle <ralf@uni-koblenz.de> writes:

     > Many sys_*() functions may be in the generic code but that
     > still doesn't mean the ports are actually using it or that no
     > special calling sequence which normally would be done in libc
     > is required.  Only people doing syscalls themselfes and not
     > through libc wrappers is worse ...

Please read the beginning of the thread. The question was about
calling from within kernel space. No libc is or can be involved...

Cheers,
   Trond
