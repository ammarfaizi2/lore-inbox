Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283938AbRLRN7c>; Tue, 18 Dec 2001 08:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283916AbRLRN7W>; Tue, 18 Dec 2001 08:59:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4481 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S283267AbRLRN7Q>; Tue, 18 Dec 2001 08:59:16 -0500
Date: Tue, 18 Dec 2001 09:00:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <3C1F323F.ED6AE4F4@idb.hist.no>
Message-ID: <Pine.LNX.3.95.1011218085823.10303A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Helge Hafting wrote:

> "Richard B. Johnson" wrote:
> 
> > 
> > Security isn't a problem with embedded systems because everything
> > that could possibly be done is handled with a "monitor". There is
> > no shell. If there is no way to execute some foreign executable,
> > you don't have a security issue unless some dumb alleged software
> > engineer added some back-doors to the monitor.
> 
> A hacker don't need a /bin/sh or any other onboard software
> to exploit some security flaw.  Assume someone discover that
> your embedded box is vulnerable to a buffer overflow attack
> of the type usually used to get a root shell.  Then they
> discover that running /bin/sh don't work.  What to do?  They
> simply put a simple little shell _in_ the buffer overflow
> code itself.  A hacker don't need to call anything, all he need
> can be downloaded as part of the exploit code.  
> 
> If the room for exploit code is thight - use a two-stage approach.
> The exploit then consists of code that download the rest of the
> code into some other RAM outside the tiny buffer.
> 
> No "dangerous" utilities on board doesn't mean the box is safe at
> all.  The buffer overflow code could contain code for 
> continuing the attack on other boxes, or anything else.
> 
> Helge Hafting


   You apparently don't know what an embedded system does.
   It is a device that uses a processor to perform some
   designed functions. It cannot do something that it
   was not designed to do although it can certainly fail
   to do what it was designed to do.

   If you want to break it, it's easier to hit it with a
   hammer or an axe. There is not any capability to "break in".
   Even if there was, what could you do? Shut off a motor?
   Screw up the ignition timing? Put porn pictures into
   medical images?

   Most embedded systems don't have network capabilities.
   Those that do are like your network printer. It's possible
   to send it junk. It's possible to send 20,000 form-feeds
   so it runs out of paper, but basically, you are just
   creating havoc with something you, or your company, owns.

   There is no way that you can teach your Hewlett-Packard
   printer to become a network rogue and break into the
   Pentagon --regardless of what you send it.

   Embedded systems that perform critical functions such
   as FMS (Flight Management Systems) have a reset button.
   If it's screwing up, and they often do, the pilot not
   flying says some four-letter prayers to be picked up
   by the cockpit microphone, hits the reset switch, waits
   for it to re-boot, and enters everything from scratch
   again --usually the entire day's flight-plan routes,
   taking nearly 1,000 key-strokes. Now, that's an embedded
   system.
 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.


