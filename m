Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSHXSON>; Sat, 24 Aug 2002 14:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSHXSON>; Sat, 24 Aug 2002 14:14:13 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:11429 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316594AbSHXSON>; Sat, 24 Aug 2002 14:14:13 -0400
Date: Sat, 24 Aug 2002 12:18:10 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: Arador <diegocg@teleline.es>, <dag@newtech.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <conman@kolivas.net>
Subject: Re: Preempt note in the logs
In-Reply-To: <1030212663.861.3.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208241214330.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24 Aug 2002, Robert Love wrote:
> On Sat, 2002-08-24 at 14:01, Thunder from the hill wrote:
> 
> > Do you think it's useful to temporarily put a lock counter into struct 
> > task (TEMPORARILY, Linus, temporarily!) and check that as well? Maybe that 
> > will point us something.
> 
> There already is, it is called preempt_count.

Yes, I know about this one. But you never know how many different-type 
locks you'll find. In the worst case there's a kernelful of crap around, 
you know.

> A lock trace would be helpful here.  But since I know normal kernel code
> is not suspect, all these users need to do is find which oddball module
> or patch they are using... e.g. watch it be nvidia.

Hey, it's not all the world that is bad. I'm not just fixed on this bug 
here. I'm suggesting this as a serious finder for broken things which 
could be used all over the place.

(Of course my (and possibly even your) great dream is that we can find 
these things before we boot the broken kernel. Good old genparsetree.pl 
and a few AI might help here.)

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

