Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbTBYIvS>; Tue, 25 Feb 2003 03:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTBYIvS>; Tue, 25 Feb 2003 03:51:18 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:29958 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267844AbTBYIvQ>; Tue, 25 Feb 2003 03:51:16 -0500
To: Ketil Froyn <kernel@ketil.froyn.name>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Weird time-warping with linux-2.4.20/i586/gcc-2.95.4pre
References: <Pine.LNX.4.40L0.0302250014330.1900-100000@ketil.hb.local>
	<87of51cgyr.fsf@amaterasu.srvr.nix>
X-Emacs: freely redistributable; void where prohibited by law.
From: Nix <nix@esperi.demon.co.uk>
Date: 25 Feb 2003 08:34:24 +0000
In-Reply-To: <87of51cgyr.fsf@amaterasu.srvr.nix>
Message-ID: <87fzqc4v3j.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Feb 2003, nix@esperi.demon.co.uk spake:
> What a wonderful bug. :)

Regardless, heavy network load *does* crash this machine.

It crashed again last night, on the 4th track of a transfer of 26 of
Chopin's Mazurkas over 100Mbit Ethernet (3c905 card, still).

A totally useless

Feb 25 02:06:15 loki kernel: Unable to handle kernel paging request at virtual address 008001c3 
Feb 25 02:06:15 loki last message repeated 2 times

got logged this time. (Full oops? Whyever should I get that?)


My network card had been totally stable until today, and I never had any
problems before upgrading to 2.4.20 (although admittedly 2.4.20 was
problem-free too, for 30 days or so).

I'm really starting to wonder if I should revert to 2.4.19 :( with
unreproducible NFS problems on the UltraSPARC and now this... (FWIW, I
managed to get some *data* out of one of those NFS problems the other
day, when it sucked my mbox-format mailbox in and received garbage in it
place. The alleged `mailbox' looked very much like a Unix directory (one
of the directories on that filesystem, naturally; the fs is ext3)...)

-- 
2003-02-01: the day the STS died.
