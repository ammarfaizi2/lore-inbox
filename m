Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSFRUAu>; Tue, 18 Jun 2002 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317588AbSFRUAt>; Tue, 18 Jun 2002 16:00:49 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:45856 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317587AbSFRUAs>; Tue, 18 Jun 2002 16:00:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-reply-to: Your message of "Tue, 18 Jun 2002 11:56:20 MST."
             <Pine.LNX.4.44.0206181155280.4552-100000@home.transmeta.com> 
Date: Wed, 19 Jun 2002 06:05:03 +1000
Message-Id: <E17KPDr-0003Pa-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206181155280.4552-100000@home.transmeta.com> you wri
te:
> 
> 
> On Wed, 19 Jun 2002, Rusty Russell wrote:
> >
> > You could do a loop here, but the real problem is the broken userspace
> > interface.  Can you fix this so it takes a single CPU number please?
> 
> NO.
> 
> Rusty, people want to do "node-affine" stuff, which absolutely requires
> you to be able to give CPU "collections". Single CPU's need not apply.

NO.  They want to be node-affine.  They don't want to specify what
CPUs they attach to.

Understand?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
