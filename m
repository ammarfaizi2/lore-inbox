Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbRCLKyJ>; Mon, 12 Mar 2001 05:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRCLKyA>; Mon, 12 Mar 2001 05:54:00 -0500
Received: from jalon.able.es ([212.97.163.2]:18307 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129496AbRCLKxv>;
	Mon, 12 Mar 2001 05:53:51 -0500
Date: Mon, 12 Mar 2001 11:53:02 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: tmwhitehead@students.wisc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: make: *** [vmlinux] Error 1
Message-ID: <20010312115302.A4210@werewolf.able.es>
In-Reply-To: <20010311205408.A5102@wioggin.awwgeez>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010311205408.A5102@wioggin.awwgeez>; from tmwhitehead@students.wisc.edu on Mon, Mar 12, 2001 at 03:54:08 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.12 tmwhitehead@students.wisc.edu wrote:
> On a compile of 2.4.2 I get the following (using make bzImage) 
> init/main.o: In function `check_fpu':
> init/main.o(.text.init+0x63): undefined reference to `__buggy_fxsr_alignment'
> make: *** [vmlinux] Error 1

If you are using pgcc, try getting a real less-buggy compiler, like egcs1.1.2
or gcc-2.95 (even 2.96 willl work).

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac18 #1 SMP Sun Mar 11 01:21:35 CET 2001 i686

