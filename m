Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSI0Pk6>; Fri, 27 Sep 2002 11:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262539AbSI0Pk6>; Fri, 27 Sep 2002 11:40:58 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:58583 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S262536AbSI0Pk5>; Fri, 27 Sep 2002 11:40:57 -0400
Date: Fri, 27 Sep 2002 17:43:02 +0200 (CEST)
From: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: Re: 2.5.32 bootfailure for nfsroot
In-Reply-To: <200209271239.g8RCdIp09188@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0209271729230.26871-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Denis Vlasenko wrote:

> > > The subject says it all.
> > > 2.5.32 doesn't boot when using nfsroot.
> > > same systems running fine with 2.4.19/2.5.31
> > >
> > > SYSTEMS:
> > >    athlon with/without preempt. (flatbak)
> > >    i586 with preempt.           (cam029205)
> > >
> > > The relevant configs/dmesg/lspci are on
> > > cam029208.student.utwente.nl/~caligula.
> > >
> > > SYMPTOMS:
> > > I'm using loadlin to load the kernels. I see the kernel loading,unzipping
> > > and then...black screen followed by reboot.
> >
> > Small update.
> > Still no joy with 2.5.33. Same results,same symptoms :(
> 
> Why do you think it is nfsroot related?
> Does it boot off local filesystem?
> --
> vda
> 


Well, it was a guess. And a very wrong one too,it appeard later on.

After I posted the message and got no reaction,I tried some different 
kernel configs,and finally a very lean one.  No preempt,i386 only,no 
mtrr,no ide,no nfsroot. The idea was let the kernel boot,and then 
let it complain  it can't find a rootsystem. Even that wouldn't work.
Same symptoms. Loadlin unzapping kernel and than whush...black screen 
followed by reboot.

A very lean kernel >2.5.32 won't boot with loadlin on my system.
So no relation to nfsroot (my mistake).

So my GUESS is,it has something to do with the interaction between loadlin 
and the kernel.

Greetz Mu



 







