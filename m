Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbSJDPHP>; Fri, 4 Oct 2002 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbSJDPGg>; Fri, 4 Oct 2002 11:06:36 -0400
Received: from aneto.able.es ([212.97.163.22]:42930 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S261964AbSJDPFh>;
	Fri, 4 Oct 2002 11:05:37 -0400
Date: Fri, 4 Oct 2002 17:10:54 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] nptl 0.2
Message-ID: <20021004151054.GA1752@werewolf.able.es>
References: <3D9D51A3.3050906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3D9D51A3.3050906@redhat.com>; from drepper@redhat.com on Fri, Oct 04, 2002 at 10:30:27 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.04 Ulrich Drepper wrote:
>
>Now that the Linux kernel is once again able to run all the tests we
>have and since glibc 2.3 was released it was time for a new code drop.
>I've uploaded the second code drop for the Native POSIX Thread
>Library:
>
>  ftp://people.redhat.com/drepper/nptl/nptl-0.2.tar.bz2
>

Fine !!

>You need

This is the hard part...

>
>- - the latest of Linus' kernel from BitKeeper (or 2.5.41 when it
>  is released);
>

Mmmm...

>- - glibc 2.3
>

Easy. I suppose it is binary compatible with 2.2.5.

>- - the very latest in tools such as
>
>  + gcc either from the current development branch or the gcc 3.2
>    from Red Hat Linux 8;
>

OK in my cooker.

>  + binutils preferrably from CVS, from H.J. Lu's latest release for
>    Linux, or from RHL 8.
>

Done.

Well, so you need:
- new binutils, easy to do.
- new gcc, already in Mandrake and RedHat (?? about SuSE and others)
- new glibc, probably the first update when Cooker and RawHide are
  unfrozen again. And it is a final release.

Problem is kernel 2.5. Too 'risky'.
I would like to ask again: could you state what new kernel features are
needed (futexes, cpu-affinity syscalls, signalling changes...).
Perhaps people can use 2.4 -ac or -aa trees (if for example nptl only
needs futexes).

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre8-jam2 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
