Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSLQS1y>; Tue, 17 Dec 2002 13:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSLQS1y>; Tue, 17 Dec 2002 13:27:54 -0500
Received: from mnh-1-20.mv.com ([207.22.10.52]:48391 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265306AbSLQS1x>;
	Tue, 17 Dec 2002 13:27:53 -0500
Message-Id: <200212171839.NAA08357@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance 
In-Reply-To: Your message of "Tue, 17 Dec 2002 09:55:28 PST."
             <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Dec 2002 13:39:22 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> That also allows the kernel to move around the SYSINFO page at will,
> and even makes it possible to avoid it altogether (ie this will solve
> the inevitable problems with UML - UML just wouldn't set AT_SYSINFO,
> so user level just wouldn't even _try_ to use it). 

Why shouldn't I just set it to where UML provides its own SYSINFO page?

				Jeff

