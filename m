Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbTCKXVB>; Tue, 11 Mar 2003 18:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261676AbTCKXVB>; Tue, 11 Mar 2003 18:21:01 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:39873 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S261675AbTCKXVA>;
	Tue, 11 Mar 2003 18:21:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15982.29106.674299.704117@gargle.gargle.HOWL>
Date: Wed, 12 Mar 2003 00:30:58 +0100
From: mikpe@csd.uu.se
To: Andrew Fleming <afleming@motorola.com>
Cc: Segher Boessenkool <segher@koffie.nl>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       <oprofile-list@lists.sourceforge.net>,
       <linuxppc-dev@lists.linuxppc.org>, <o.oppitz@web.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] oprofile for ppc
In-Reply-To: <FEB94991-540B-11D7-BAD1-000393C30512@motorola.com>
References: <3E6D469C.8060209@koffie.nl>
	<FEB94991-540B-11D7-BAD1-000393C30512@motorola.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Fleming writes:
 > 
 > On Monday, Mar 10, 2003, at 20:14 US/Central, Segher Boessenkool wrote:
 > 
 > > Albert Cahalan wrote:
 > >> On Sun, 2003-03-09 at 22:50, Segher Boessenkool wrote:
 > >>> Benjamin Herrenschmidt wrote:
 > >>>> Beware though that some G4s have a nasty bug that
 > >>>> prevents using the performance counter interrupt
 > >>>> (and the thermal interrupt as well).
 > >>>
 > >>> MPC7400 version 1.2 and lower have this problem.
 > >> MPC7410 you mean, right? Are those early revisions
 > >> even popular?
 > >
 > > 7400 and 7410 core versions are identical, afaik.  I don't
 > > think any 7410 core lower than version 2.0 was ever used
 > > in any consumer machines.  ymmv.
 > 
 > I've been looking into this, and all versions of the 7410 before 1.3 
 > (where it was fixed) have this errata.  And there is no version of the 
 > 7410 above 1.4.  Some of the machines with 7410s, and all of the 
 > machines with 7400s have this problem, I believe.

Is this bug restricted to 7400/7410 only, or does it affect the
750 (and relatives) and 604/604e too?

I'm thinking about ppc support for my perfctr driver, and whether
overflow interrupts are worth supporting or not given the errata.

/Mikael
