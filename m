Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275983AbRJUMWA>; Sun, 21 Oct 2001 08:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275989AbRJUMVv>; Sun, 21 Oct 2001 08:21:51 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32516 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S275983AbRJUMVe>;
	Sun, 21 Oct 2001 08:21:34 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15314.48596.433523.34566@cargo.ozlabs.ibm.com>
Date: Sun, 21 Oct 2001 22:21:40 +1000 (EST)
To: "Kalyan" <kalyand@cruise-controls.com>
Cc: "ML-linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: wild pointer!!!!!
In-Reply-To: <017f01c159b7$83943520$aac8a8c0@cruise>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com>
	<m33d4gjaoa.fsf@linux.local>
	<20011020171730.A28057@parallab.uib.no>
	<3BD28673.1060302@sap.com>
	<20011021120755.A1252@parallab.uib.no>
	<017f01c159b7$83943520$aac8a8c0@cruise>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalyan writes:

>         I recently ported the linux kernel v 2.4.11-pre5  to MDPPro (
> MPC860T processor ) board..the kernel dies with an Oops and everytime at a
> different place....

What code base did you start from?  Linus' official 2.4.11-pre5
release, or the linuxppc_2_4_devel PPC development tree at
ppc.bkserver.net?  See http://www.penguinppc.org/dev/kernel.shtml for
details on how to access the PPC development tree.  That tree would
have the most up-to-date support for the MPC860T processor.

>         upon back tracing i found that at some point the kernel tries to
> execute code in Letext ( according to System.map)....

Hmmm, I don't know where that symbol would have come from, sorry.  It
doesn't appear anywhere in the kernel source that I can find.  Did you
add it?

>         it'd be great if someone can explain me what this Letext is and why
> is the control going there???

I suggest you ask on the linuxppc-dev@lists.linuxppc.org mailing list,
you will find other hackers working on Linux for MPC8xx processors
there.

Paul.
