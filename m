Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTATTDp>; Mon, 20 Jan 2003 14:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTATTDp>; Mon, 20 Jan 2003 14:03:45 -0500
Received: from [81.2.122.30] ([81.2.122.30]:51462 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266637AbTATTDo>;
	Mon, 20 Jan 2003 14:03:44 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301201912.h0KJCrru006239@darkstar.example.net>
Subject: Re: Promise PDC20268 FastTrack 100 TX2 (PDC20268)
To: lkml@scienceworks.com
Date: Mon, 20 Jan 2003 19:12:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <20030120183442.GA3440@poseidon.wasserstadt.de> from "lkml@scienceworks.com" at Jan 20, 2003 07:34:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a Promise FastTrack 100 TX2 (PDC20268) IDE-controller
> (BIOS v2.00.0.24) used in a linux MD-RAID.  Aside from various
> other annoying Promise-problems, I am not able to perform a
> remote boot because the brain-dead Promise-BIOS "complains" that
> no array is defined, and requires one to press ESC to continue
> booting.  I would very much appreciate any tips as to how I can
> circumvent this "feature".

Well, if you don't usually need a keyboard on that machine, in theory,
you might be able to connect the keyboard input to the PS/2 mouse port
of another machine, and write a program to send the correct bytes for
that keypress to the other machine.  Then, you could reboot the
machine with the Promise card in it, then log in to the other machine,
and run the program to send the keypress.

Not sure how practical this solution would be though...  You'd
probably have to simulate the keyboard initialisation responses as
well, which would make it a bit complicated

John.
