Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbREUUB4>; Mon, 21 May 2001 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbREUUBq>; Mon, 21 May 2001 16:01:46 -0400
Received: from jalon.able.es ([212.97.163.2]:18109 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262184AbREUUBe>;
	Mon, 21 May 2001 16:01:34 -0400
Date: Mon, 21 May 2001 22:01:26 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Richard Henderson <rth@twiddle.net>
Cc: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Geert Uytterhoeven <geert@linux-m68k.org.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
Message-ID: <20010521220126.A1099@werewolf.able.es>
In-Reply-To: <3B083878.1785C27D@mandrakesoft.com> <13469.990414470@kao2.melbourne.sgi.com> <20010521005113.A19651@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010521005113.A19651@twiddle.net>; from rth@twiddle.net on Mon, May 21, 2001 at 09:51:13 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.21 Richard Henderson wrote:
> On Mon, May 21, 2001 at 01:07:50PM +1000, Keith Owens wrote:
> > does cause a section conflict, egcs 1.1.2.
> > 
> > Interestingly enough, if var[12] are together, without the intervening
> > text, then gcc does not flag an error, instead it puts both variables
> > in section .data.init and marks it as read only.  This looks like a bug
> > in gcc.
> 
> Fixed in compilers newer than 2 years old.
> 

Somebody should officially certify 2.95.2 (or better 2.95.3, if all the
kernel related bugs are solved), and change:

"The recommended compiler for the kernel is egcs 1.1.2 (gcc 2.91.66), and it
should be used when you need absolute stability. You may use gcc 2.95.x
instead if you wish, although it may cause problems."

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac11 #2 SMP Fri May 18 12:27:06 CEST 2001 i686

