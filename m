Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbTCJFwP>; Mon, 10 Mar 2003 00:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbTCJFwP>; Mon, 10 Mar 2003 00:52:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13611 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262733AbTCJFwO>; Mon, 10 Mar 2003 00:52:14 -0500
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	<20030307233916.Q17492@flint.arm.linux.org.uk>
	<m1d6l2lih9.fsf@frodo.biederman.org>
	<20030308100359.A27153@flint.arm.linux.org.uk>
	<m18yvpluw7.fsf@frodo.biederman.org>
	<20030308161309.B1896@flint.arm.linux.org.uk>
	<m1vfytkbsk.fsf@frodo.biederman.org> <1047209545.4102.3.camel@sonja>
	<m1adg4kbjn.fsf@frodo.biederman.org> <1047219550.4102.6.camel@sonja>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Mar 2003 23:01:56 -0700
In-Reply-To: <1047219550.4102.6.camel@sonja>
Message-ID: <m1wuj7iwtn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> writes:

> Am Son, 2003-03-09 um 12.46 schrieb Eric W. Biederman:
> 
> > I use etherboot.  It is small and has not problems acting as network
> > bootstrap program if you are stuck with EFI.
> 
> Sorry for being unclear here; I'm neither using IA64 nor EFI. This is
> plain etherboot resp. PXE/etherboot on ia32.
> 
> > Etherboot can load to any address < 4GB and can jump to a 32bit entry
> > point.  It's not rocket science or magic just good open source code.
> 
> Maybe etherboot isn't the culprit here, but mknbi won't let me
> create bigger tagged boot kernels.

Hmm.  I don't know.   It looks like a tool chain problem.  Maybe
a very old/strange version of mknbi.  I have never seen a 1MB limit
on any of the tools.  Though I have not played with the version of
mknbi that came with netboot.

Anyway if you re-ask on the etherboot-users list I am certain someone
can get this sorted out for you.

Eric
