Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSK1SoO>; Thu, 28 Nov 2002 13:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSK1SoO>; Thu, 28 Nov 2002 13:44:14 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:7947 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S266701AbSK1SoN> convert rfc822-to-8bit; Thu, 28 Nov 2002 13:44:13 -0500
Date: Thu, 28 Nov 2002 19:51:33 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <15846.25140.759632.709205@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0211281949030.1818-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2002, Trond Myklebust wrote:

> >>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:
>
>     >> Does it also occur if you play around with setting rsize and
>     >> wsize = 1024?
>
>      > I'm afraid so - I just double-checked...
>
> Given that you are saying that even synchronous RPC (which is the
> default for r/wsize = 1024) is failing, then my 2 main suspicions are
>
>   - hardware failure: Have you tried this on several different
>     server/client combinations and hardware combinations?

I have thought of this too but never seen traces of hardware failure
otherwise. I will try other hardware tomorrow (I'm tight on time today)
- although I haven't got access to that many different machines.

>   - gcc miscompile: which version of gcc are you using?

It is the standard Debian Woody gcc:

Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
moffe@carlsberg:~# dpkg -l gcc
Ønsket=Ukendt/Installér/Fjern/Udrens/Tilbagehold
| Status=Ikke/Installeret/Opsæt.-files/Upakket/Opsætn.-fejl/Halvt-inst.
|/ Fjl?=(ingen)/Tilbageholdt/Geninst.-krævet/X=begge-dele (Status,Fjl:
versaler=slemt)
||/ Navn                Version             Beskrivelse
+++-===================-===================-======================================================
ii  gcc                 2.95.4-14           The GNU C compiler.

I will report ASAP.

Thanks so far

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Linux hackers are funny people: They count the time in patchlevels.
----------------------------------[ moffe at amagerkollegiet dot dk ] --

