Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264493AbRFOTWY>; Fri, 15 Jun 2001 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbRFOTWO>; Fri, 15 Jun 2001 15:22:14 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:51720 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264493AbRFOTWD>;
	Fri, 15 Jun 2001 15:22:03 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106151921.f5FJLsc03635@saturn.cs.uml.edu>
Subject: Re: [patch] nonblinking VGA block cursor
To: ljb@devco.net (Leon Breedt)
Date: Fri, 15 Jun 2001 15:21:54 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010615162249.A1328@rinoa.rinoa> from "Leon Breedt" at Jun 15, 2001 04:22:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Breedt writes:

> Attached is a patch to enforce a non-blinking, FreeBSD-syscons like
> block cursor in console mode.
> 
> This is useful for laptop types, or people like me who really really
> detest a blinking cursor.
> 
> NOTE: It disables the softcursor escape codes 
>       (/usr/src/linux/Documentation/VGA-softcursor.txt), since I don't 
>       ever want anything to change my cursor shape/style :)

I've seen this 666 times too often.

Non-blinking cursors are just wrong. You need to patch your brain.
You really fucked up, because now apps can't restore your cursor
to proper behavior as defined by IBM.

The blinking cursor is implemented in your video hardware.
IBM knew what was right for you. Millions of people know that
the blinking cursor is good. It is so right that a proper GUI
will implement the blinking cursor even without hardware support.

Of course FreeBSD has a block cursor. It was easy to program,
and it seems nice to the pot-smoking hippies out in Berkeley.
FreeBSD doesn't define standards. FreeBSD breaks standards.
(zombie creation, "ps -ef", partition tables, pty allocation...)
Gee, kind of like Microsoft, except Microsoft got the cursor right!

Ever wonder why IBM supports Linux instead of FreeBSD? Hmmm?
