Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbTCILgp>; Sun, 9 Mar 2003 06:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbTCILgo>; Sun, 9 Mar 2003 06:36:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1065 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262133AbTCILgo>; Sun, 9 Mar 2003 06:36:44 -0500
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Mar 2003 04:46:20 -0700
In-Reply-To: <1047209545.4102.3.camel@sonja>
Message-ID: <m1adg4kbjn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> writes:

> Am Sam, 2003-03-08 um 18.28 schrieb Eric W. Biederman:
> 
> > All of my policy is already in user space and as I boot over the
> > network size is not a large constraint. 
> 
> Just curious, for me size *is* a large constraint just because I'm
> booting over network. The size of a kernel must not exceed 1M in
> size here and that brought me quite some troubles with the growth
> of 2.5.x. How did you get around this?

I use etherboot.  It is small and has not problems acting as network
bootstrap program if you are stuck with EFI.

Etherboot can load to any address < 4GB and can jump to a 32bit entry
point.  It's not rocket science or magic just good open source code.

Eric
