Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTFVRSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTFVRSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:18:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:12311 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264832AbTFVRSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:18:22 -0400
Date: Sun, 22 Jun 2003 10:32:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: acme@conectiva.com.br, cw@f00f.org, torvalds@transmeta.com,
       geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-Id: <20030622103251.158691c3.akpm@digeo.com>
In-Reply-To: <200306221522.29653.phillips@arcor.de>
References: <20030621125111.0bb3dc1c.akpm@digeo.com>
	<20030622014345.GD10801@conectiva.com.br>
	<20030621191705.3c1dbb16.akpm@digeo.com>
	<200306221522.29653.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 17:32:27.0608 (UTC) FILETIME=[40208D80:01C338E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> As for compilation speed, yes, that sucks.  I doubt there's any rational 
>  reason for it, but I also agree with the idea that correctness and binary 
>  code performance should come first, then the compilation speed issue should 
>  be addressed.

No.  Compilation inefficiency directly harms programmer efficiency and the
quality and volume of code the programmer produces.  These are surely the
most important things by which a toolchain's usefulness should be judged.

I compile with -O1 all the time and couldn't care the teeniest little bit
about the performance of the generated code - it just doesn't matter.

I'm happy allowing those thousands of people who do not compile kernels all
the time to shake out any 3.2/3.3 compilation problems.


Compilation inefficiency is the most serious thing wrong with gcc.

