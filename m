Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSKJS5u>; Sun, 10 Nov 2002 13:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265079AbSKJS5u>; Sun, 10 Nov 2002 13:57:50 -0500
Received: from host194.steeleye.com ([66.206.164.34]:7181 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265066AbSKJS5q>; Sun, 10 Nov 2002 13:57:46 -0500
Message-Id: <200211101904.gAAJ4RX12573@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BOGUS: megaraid changes 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Sun, 10 Nov 2002 10:43:17 PST." <Pine.LNX.4.44.0211101039100.9581-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2002 14:04:27 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> I've said this before, I'll say it again: anything that breaks
> _working_  is BAD. Don't do it. Don't make up new ways to screw with
> people who want  to test. Don't add features that have _no_ meaning
> except to irritate  people.

OK, what about the runtime warning with no requirement for a special flag to 
enable attachment.

> The compile-time warning is _plenty_ good enough. 

I don't necessarily agree.  It's easy to miss in all the build noise (most 
average users don't do make -s).  And the warning isn't that fierce (it 
complains about a prototype mismatch), so even if it's noticed, it might get 
ignored.  At least if we have a run time warning, it's in the logs for all to 
see when a problem gets posted to any given mailing list.

James


