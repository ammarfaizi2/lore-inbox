Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSDOBFx>; Sun, 14 Apr 2002 21:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSDOBFw>; Sun, 14 Apr 2002 21:05:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312558AbSDOBFv>; Sun, 14 Apr 2002 21:05:51 -0400
Date: Sun, 14 Apr 2002 18:04:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 does not boot
In-Reply-To: <UTC200204142229.WAA577107.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.33.0204141803010.1206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Apr 2002 Andries.Brouwer@cwi.nl wrote:
>
> Booting 2.5.8 yields a crash at ide-disk.c:360
> 	BUG_ON(drive->tcq->active_tag != -1);

The TCQ stuff is definitely experimental, you should probably configure it
out for now.

		Linus

