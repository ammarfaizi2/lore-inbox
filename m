Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSFTVOZ>; Thu, 20 Jun 2002 17:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSFTVOY>; Thu, 20 Jun 2002 17:14:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19584 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S315544AbSFTVOS> convert rfc822-to-8bit; Thu, 20 Jun 2002 17:14:18 -0400
Subject: Re: latest linus-2.5 BK broken
From: "Timothy D. Witham" <wookie@osdl.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D123DB9.8090909@evision-ventures.com>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
	<m1d6umtxe8.fsf@frodo.biederman.org>
	<20020620103003.C6243@host110.fsmlabs.com> 
	<3D123DB9.8090909@evision-ventures.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 14:13:00 -0700
Message-Id: <1024607580.1829.26.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-20 at 13:40, Martin Dalecki wrote:
> U¿ytkownik Cort Dougan napisa³:
> > "Beating the SMP horse to death" does make sense for 2 processor SMP
> > machines.  When 64 processor machines become commodity (Linux is a
> > commodity hardware OS) something will have to be done.  When research
> 
> 
> 8. Amdahls law is math and not a decret from the Central Komitee of
> the Kommunist Party or George Bush. You can not overrule it.
> 
  Boy, I haven't been beat up by Amdahl's law for at least 10 years. :-)

  A point to mention is that Amdahl's law also applies to scaling on
  clusters.  Same issues as SMP as far as application scalability
  is concerned.

  But the point is that there are a whole bunch of applications that
  can have the serial portion reduce to such a small amount that they
  can benefit from lots of CPUS.  

> One exception could be dedicated rendering CPUs - which is the
> direction where graphics cards are apparently heading - but they
> will hardly ever need a general purpose operating system. But even then -
> I'm still in the bunch of people who are not interrested
> in any OpenGL or Direct whatever... The worsest graphics cards
> those days drive my display screens at the resolutions I wish them too
> just fine.
> 
> PS. I'm sick of seeing bunches of PC's which are accidentally in
> the same room nowadays in the list of the 500 fastest computers
> on the world. It makes this list useless...
> 
> If one want's to have a grasp on how the next generation of
> really fast computers will look alike. Well: they will be based
> on Johnson-junctions. TRW will build them (same company
> as Voyager sonde). Look there they don't plan for thousands of CPUs
> they plan for few CPUs in liquid helium:
> 
> http://www.trw.com/extlink/1,,,00.html?ExternalTRW=/images/imaps_2000_paper.pdf&DIR=2
> 
> 

  You know there used to be a whole bunch of companies doing this
sort of work and they all went out of business because people could
build a cluster out of off the shelf parts for 1/10 of the cost and
get good enough performance.  ETA, CDC, the old Cray the list goes
on. All gone from the CPU business because good enough cheap enough
wins every time.

Tim

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

