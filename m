Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSFQPBU>; Mon, 17 Jun 2002 11:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSFQPBT>; Mon, 17 Jun 2002 11:01:19 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:20001 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S314340AbSFQPBS> convert rfc822-to-8bit; Mon, 17 Jun 2002 11:01:18 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A795A@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Martin Dalecki'" <dalecki@evision-ventures.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.22 broke modversions
Date: Mon, 17 Jun 2002 09:59:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> U¿ytkownik Kai Germaschewski napisa³:
> > On Mon, 17 Jun 2002, Mikael Pettersson wrote:
> > 
> > 
> >>Something in the 2.5.22 Makefile/Rule.make changes broke
> >>modversions on my P4 box. For some reason, a number of
> >>exporting objects, including arch/i386/kernel/i386_ksyms,
> >>weren't given -D__GENKSYMS__ at genksym-time, with the
> >>effect that the resulting .ver files became empty, and the
> >>kernel exported the symbols with unexpanded _R__ver_ suffixes.
> > 
> > 
> > You're right, thanks for the report. The fix is appended ;)
> 
> BTW> There is some different thing broken: TEMP files
> used by make menuconfig don't get clean up even after make distclean.
> 
Is it just me? I am using linus bk version, and I don't see the Kernel
version updated in Makefile to 2.5.22?  

B.
