Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTCFMq7>; Thu, 6 Mar 2003 07:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268019AbTCFMq7>; Thu, 6 Mar 2003 07:46:59 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:36275 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268016AbTCFMq6>;
	Thu, 6 Mar 2003 07:46:58 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15975.17847.535048.258612@gargle.gargle.HOWL>
Date: Thu, 6 Mar 2003 13:57:27 +0100
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 fixes for 2.4.21-pre5
In-Reply-To: <p73isuw67vv.fsf@amdsimf.suse.de>
References: <15974.15180.311304.526712@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<p73isuw67vv.fsf@amdsimf.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Mikael Pettersson <mikpe@user.it.uu.se> writes:
 > 
 > > This fixes a linkage error caused by the IDE layer's use of the
 > > new ndelay() macro. I simply cloned the i386 implementation.
 > > 
 > > This also silences two assembler warnings in bootsect.S and setup.S.
 > > Those warnings are caused by a change in binutils' behaviour a LONG
 > > time ago. This can't be fixed for i386 in the official stable kernel
 > > since it breaks old tool chains, but that's not an issue for x86-64.
 > 
 > I fixed it some time ago in my tree, but Marcelo dropped the fixes,
 > sorry.

Would that be your personal x86-64 tree?
I had a look at x86-64.org's browsable CVS before I posted my patch,
but none of the things my patch fixed were fixed there.

/Mikael
