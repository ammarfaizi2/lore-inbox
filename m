Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293309AbSB1S6z>; Thu, 28 Feb 2002 13:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293674AbSB1S45>; Thu, 28 Feb 2002 13:56:57 -0500
Received: from mother.ludd.luth.se ([130.240.16.3]:59296 "EHLO
	mother.ludd.luth.se") by vger.kernel.org with ESMTP
	id <S293677AbSB1Sxc>; Thu, 28 Feb 2002 13:53:32 -0500
Date: Thu, 28 Feb 2002 19:53:30 +0100 (MET)
From: texas <texas@ludd.luth.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <E16gAJn-0005fo-00@the-village.bc.nu>
Message-ID: <Pine.GSU.4.33.0202281949410.27596-100000@father.ludd.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aww, it died again, lockup (hard - caps lock light on keyboard doesn't
react when the button is pressed) and cold boot required to get it up
again.  That's what I deserve for getting my hopes up.

Tried 2.2 again thinking it might work now with the fixed BIOS settings
but no, still getting the "Keyboard: Timeout - AT keyboard not present?"
and "hda: lost interrupt" messages. So I can't even boot 2.2 and I have no
clue what to try next. Instead, I'll concentrate on trying to get it
stable on 2.4. I've read that the random hard lockups can be caused by the
network card I'm using (built in Intel EtherExpress Pro 100 (PILA8470B))
and are now trying the e100 driver that Intel released for the card
instead of the driver that comes with the kernel (by Donald Becker). The
Intel driver is reported to have fixed similar problems for other people.
We'll see what it can do for me.

Other suggestions on what I could try to find the cause of the lockups are
much appreciated.

Thanks,
Johan


