Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbSJHOzp>; Tue, 8 Oct 2002 10:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263223AbSJHOzp>; Tue, 8 Oct 2002 10:55:45 -0400
Received: from host194.steeleye.com ([66.206.164.34]:2312 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263217AbSJHOzn>; Tue, 8 Oct 2002 10:55:43 -0400
Message-Id: <200210081501.g98F1DR02225@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@redhat.com>, James.Bottomley@HansenPartnership.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Tue, 08 Oct 2002 13:56:00 +0200." <Pine.NEB.4.44.0210081352470.8340-100000@mimas.fachschaften.tu-muenchen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 11:01:13 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bunk@fs.tum.de said:
> make[1]: *** No rule to make target `arch/i386/mach-voyager/
> trampoline.o', needed by `arch/i386/mach-voyager/built-in.o'.  Stop.
> make: *** [arch/i386/mach-voyager] Error 2 

That one's pulled in from ../kernel by the vpath in mach-voyager (or should 
be).  It builds for me, so it could be the version of make you are using?

James


