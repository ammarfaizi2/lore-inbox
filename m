Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbTCPQiP>; Sun, 16 Mar 2003 11:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbTCPQiP>; Sun, 16 Mar 2003 11:38:15 -0500
Received: from ns.miraclelinux.com ([219.101.34.26]:38652 "EHLO
	dns01.miraclelinux.com") by vger.kernel.org with ESMTP
	id <S262688AbTCPQiO>; Sun, 16 Mar 2003 11:38:14 -0500
To: rddunlap@osdl.org
Cc: jamagallon@able.es, mikpe@user.it.uu.se,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hyoshiok@miraclelinux.com
Subject: Re: [Perfctr-devel] Re: perfctr-2.5.0 released
In-Reply-To: <33207.4.64.238.61.1047616615.squirrel@www.osdl.org>
References: <200303110002.h2B02Uxa025848@harpo.it.uu.se>
	<20030314012502.GA20357@werewolf.able.es>
	<33207.4.64.238.61.1047616615.squirrel@www.osdl.org>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20030317014736O.hyoshiok@miraclelinux.com>
Date: Mon, 17 Mar 2003 01:47:36 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have made a memory profiling tool based on the perfctr 2.5.0.
http://downloads.sourceforge.jp/hardmeter/2646/hardmeter-030314.tar.gz

The tool (hardmeter) is
1) patch to perfctr 2.5.0
2) ebs (PEBS (Precise Event Based Sampling) memory profiling tool)
3) API

Thanks,
  Hiro

> >
> > On 03.11, Mikael Pettersson wrote:
> >> Version 2.5.0 of perfctr, the Linux/x86 performance
> >> monitoring counters driver, is now available at the usual
> >> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
> >>
> >
> > Perhaps this has been asked for a million times, but I'm new to
> > perfctrs...
> > Is there any tool available to profile a program based on this ?
> > I have seen perfex, but that gives total counts. I would like something like
> > gprof... We are now optimizing some software and I would like to make my
> > colleagues leave Windows (they use Intel's VTune) and go to Linux.
> > Or at least compare the same kind of things between VTune on win and
> > 'something' in Linux that also uses the counters. They don't seem to trust
> > gprof. And, looking at the results, I'm beginning to untrust VTune...
> 
> I hope that Mikael knows of some native Linux tools for this.
> However, Intel did announce Vtune for Linux recently (might still be
> in beta test), and there was a SuSE patch for it posted at
> kernelnewbies.org also.  See:
> 
> http://www.linuxhardware.org/comments.pl?sid=364&cid=530
> http://www.linuxhardware.org/articles/03/01/17/1633229.shtml
> http://kernelnewbies.org/kernels/SuSE81/SOURCES/patches.i386/50_vtune-ia32
>   (warning: this is for 2.4.19)
> 
> or google for "+vtune +linux".
> 
> ~Randy
