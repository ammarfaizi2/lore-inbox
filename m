Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287508AbSALVWx>; Sat, 12 Jan 2002 16:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSALVWn>; Sat, 12 Jan 2002 16:22:43 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:52749 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287508AbSALVW0>; Sat, 12 Jan 2002 16:22:26 -0500
Message-ID: <3C40A8EF.D45600E3@linux-m68k.org>
Date: Sat, 12 Jan 2002 22:21:51 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Rob Landley <landley@trommello.org>, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org> <20020112075638.A5098@hq.fsmlabs.com> <3C4076EC.FEA42077@linux-m68k.org> <20020112122307.A6034@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> We're having a write only discussion - time to stop.

Sorry, but I'm still waiting for the proof that preempting deadlocks the
system.
If n running processes have together m time slices, after m ticks every
process will have run it's full share of the time, no matter how often
you schedule. (I assume here a correct time accounting, which is
currently not the case, but that's a different (and not new) problem.)
So even the low priority process will have the same time as before to do
it's job, it will be delayed, but it will not be delayed forever, so I'm
failing to see how preempting Linux should deadlock.

bye, Roman
