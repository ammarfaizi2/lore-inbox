Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSEEXHL>; Sun, 5 May 2002 19:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313817AbSEEXHK>; Sun, 5 May 2002 19:07:10 -0400
Received: from bnathan.remote.ics.uci.edu ([128.195.36.153]:21742 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S313307AbSEEXHJ>; Sun, 5 May 2002 19:07:09 -0400
Subject: Re: Linux 2.4.18 floppy driver EATS floppies
To: cj.rankin@ntlworld.com (Chris Rankin)
Date: Sun, 5 May 2002 09:50:49 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, paul@paulbristow.net,
        chaffee@cs.berkeley.edu
In-Reply-To: <no.id> from "Chris Rankin" at May 05, 2002 02:17:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020505165049.377D889546@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am discovering that any floppy disks that I try to use under Linux
> don't last very long. This seems to be true with both my UP and SMP 
> machines, neither of which has ever used its floppy drive enough for
> me to believe that the hardware is reaching the end of its life.

Make sure the boot-time floppy seek option is enabled in your BIOS. While
it shouldn't be necessary nowadays in theory, I've seen some
motherboard/(1.44MB 3.5") floppy drive combinations that require it to be
enabled for the floppy drive to work with any level of consistency.

Also, if a particular disk is acting really strange, try ejecting it,
reinserting it, and trying again.

Both of these pieces of advice apply to Windows as well as Linux, FWIW.

-Barry K. Nathan <barryn@pobox.com>
