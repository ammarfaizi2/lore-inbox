Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbQLDAkG>; Sun, 3 Dec 2000 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLDAj4>; Sun, 3 Dec 2000 19:39:56 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:36761 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130429AbQLDAjp>; Sun, 3 Dec 2000 19:39:45 -0500
Date: Mon, 4 Dec 2000 01:10:19 +0100
To: Dax Kelson <dax@gurulabs.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre3 (FireWire issue)
Message-ID: <20001204011018.A3593@storm.local>
Mail-Followup-To: Dax Kelson <dax@gurulabs.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com> <Pine.SOL.4.30.0011302253590.28037-100000@ultra1.inconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.30.0011302253590.28037-100000@ultra1.inconnect.com>; from dax@gurulabs.com on Thu, Nov 30, 2000 at 11:00:07PM -0700
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 11:00:07PM -0700, Dax Kelson wrote:
> Linus Torvalds said once upon a time (Tue, 28 Nov 2000):
> 
> >  - pre3:
> >     - Andreas Bombe: ieee1394 cleanups and fixes
> 
> Linus, Andreas,
> 
> I've been using this same config since FireWire was merged, just tried out
> test12-pre3 and got an unresolved symbol problem with raw1394.o

Frankly, I don't know where the missing symbols could come from.
Nothing in that area was recently changed.  The patch merged into pre3
was just removing Linux 2.2 compatibility macros and fixing two bugs,
symbols were not messed with.

I haven't compiled pre3 myself so far, however.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
