Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264044AbRFKJpF>; Mon, 11 Jun 2001 05:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264047AbRFKJo4>; Mon, 11 Jun 2001 05:44:56 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:64517 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264044AbRFKJou>; Mon, 11 Jun 2001 05:44:50 -0400
Message-ID: <3B2492AD.C2878479@idb.hist.no>
Date: Mon, 11 Jun 2001 11:43:09 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <9fq2ce$gkb$1@forge.intermeta.de> <200106082254.f58MsWE487361@saturn.cs.uml.edu> <9g20fn$on4$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" wrote:

> I had an interesting discussion with my brother-in-law at this
> weekend: What is source code?

The GPL covers this, if you're using it:

"The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable."

> What if there is really a warbled indivdual that can write a driver in
> object code? Or at least in x86 assembler and then performs the magic
> necessary to link it into the kernel?

You may of course write a driver/program by "cat > file.o" and end up
with a program with no source.  The gpl says source is 
"the preferred form of the work for making modifications to it."
So this object file does not work with the gpl because object files
is not a preferred form for making modifications.  This could change
if programmers in general change to *prefer* editing .o files  *instead* 
of working with source and compilers.  Winning the lottery every time
is more probable though...
 
Source in any language, even assembly, qualify.  But note the
"preferred form", merely disassembling the object file is
dubious.  So is deliberately obfuscated source.

> Is this a "binary only" driver or just a driver on par with the NVidia
> that is just "GPL'ed but unreadable"?

It is definitely binary only, as there is no source.  That don't
nullify your obligation to provide source though, so you can't
distribute it under the GPL.

Try reading /usr/share/common-licenses/GPL , it isn't that long and
have many answers to such questions.

Helge Hafting
