Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSFRSzu>; Tue, 18 Jun 2002 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSFRSzt>; Tue, 18 Jun 2002 14:55:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56337 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317547AbSFRSzs>; Tue, 18 Jun 2002 14:55:48 -0400
Date: Tue, 18 Jun 2002 11:56:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KO4i-0002xn-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206181155280.4552-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Rusty Russell wrote:
>
> You could do a loop here, but the real problem is the broken userspace
> interface.  Can you fix this so it takes a single CPU number please?

NO.

Rusty, people want to do "node-affine" stuff, which absolutely requires
you to be able to give CPU "collections". Single CPU's need not apply.

		Linus

