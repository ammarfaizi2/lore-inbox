Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTEIRk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTEIRk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:40:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263364AbTEIRk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:40:56 -0400
Date: Fri, 9 May 2003 10:49:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Dave Hansen <haveblue@us.ibm.com>, Jamie Lokier <jamie@shareable.org>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] i386 uaccess to fixmap pages
In-Reply-To: <200305091331_MC3-1-3822-4B95@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305091049270.27057-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 May 2003, Chuck Ebbert wrote:
> 
>  /arch/i386/kernel/doublefault.c:
> 
> #define ptr_ok(x) ((x) > 0xc0000000 && (x) < 0xc1000000)

That's just wrong _regardless_. Bad Linus. I was lazy when doing the 
double-fault verification.

		Linus

