Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318652AbSHQNAw>; Sat, 17 Aug 2002 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSHQNAw>; Sat, 17 Aug 2002 09:00:52 -0400
Received: from h-64-105-136-5.SNVACAID.covad.net ([64.105.136.5]:10932 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318652AbSHQNAw>; Sat, 17 Aug 2002 09:00:52 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 17 Aug 2002 06:02:16 -0700
Message-Id: <200208171302.GAA07962@adam.yggdrasil.com>
To: aia21@cantab.net, axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, m.c.p@wolk-project.de,
       torvalds@transmeta.com
Subject: Re: IDE?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I just looked at the patch to switch to "2.4 forward port"
version of drivers/ide.  If I got my shell commands right, Martin's
tree is 8606 lines shorter than the 2.4 forward port.

	2.4 forward port	49,205 lines
	Martin's version	40,599 lines
				------------
				 8,606 lines difference

	It's often amazing how much cleaning up it takes to shrink
code a little bit.  Shrinking the IDE tree this much is a lot of
work to throw away.

	In comparison, I think Niklaus Wirth's Modula-2 compiler for
the Lilith machine was 5,000 lines.

	Is the 2.5.31 IDE tree that buggy?  I would hope that stamping
out bugs from Martin's tree would be less work than cleaning up
the 2.4 version to that point again.

>If you can work with him, then it would seem he would be well suited for
>the job... Assuming he wants it... Bartlomiej?

	I'd be quite relieved if we could convince Bartlomiej to
adopt Martin's tree and continue with Martin's tree as at least
a configuration option.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
