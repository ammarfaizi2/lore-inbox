Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSFWVlD>; Sun, 23 Jun 2002 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSFWVlC>; Sun, 23 Jun 2002 17:41:02 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:50630
	"EHLO awak") by vger.kernel.org with ESMTP id <S317142AbSFWVlB> convert rfc822-to-8bit;
	Sun, 23 Jun 2002 17:41:01 -0400
Subject: [OT] Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Landley <landley@trommello.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E17LmrQ-0002vp-00@the-village.bc.nu>
References: <E17LmrQ-0002vp-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 23 Jun 2002 23:40:14 +0200
Message-Id: <1024868414.1097.38.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 22/06/2002 à 17:31, Alan Cox a écrit :
> > A microkernel design was actually made to work once, with good performance.  
> > It was about fifteen years ago, in the amiga.  Know how they pulled it off?  
> > Commodore used a mutant ultra-cheap 68030 that had -NO- memory management 
> > unit.
> 
> Vanilla 68000 actually. And it never worked well - the UI folks had
> to use a library not threads. The fs performance sucked

<troll feeding>
IIRC all simple UI things were done int the "input task" context (the
task moving the mouse pointer, to simplify things) and more heavy duty
had to be offloaded to the right task - using message passing of course.
This was not the intended design, which was to make Intuition a real
device (in the amiga sense, i.e. it could have its own task), but you
know, AmigaOS was a commercial proprietary OS with deadlines and a
complex history. That's why it had a really sucky fs, too (put your
floppy in the drive, type dir, drink a coffee while listening to your
disk being eaten, see the command output one-line-by-second).

	Xav

