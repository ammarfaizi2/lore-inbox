Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292959AbSCDWqc>; Mon, 4 Mar 2002 17:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCDWqV>; Mon, 4 Mar 2002 17:46:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292960AbSCDWqN>; Mon, 4 Mar 2002 17:46:13 -0500
Subject: Re: Linux 2.4.19pre2-ac2 || Linux 2.4.18-ac3, compilation error on
To: stephan@a2000.nu
Date: Mon, 4 Mar 2002 23:00:42 +0000 (GMT)
Cc: mathieu@accellion.com (Mathieu Legrand), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203042332160.9623-100000@ddx.a2000.nu> from "stephan@a2000.nu" at Mar 04, 2002 11:34:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i1Ri-0000wl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> same problem here
> 2.4.19-ac2 compiles ok
> when applying the ac patches is fails on the ide.h
> 
> Reading specs from /usr/lib/gcc-lib/sparc-redhat-linux/egcs-2.91.66/specs
> gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

egcs is not a recommended compiler for the -ac tree. I don't however think
that is the problem. You need some pending patches from DaveM and possibly
also some other further fixes.

I'm afraid sparc is right at the bottom of the platforms I care about
