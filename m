Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312920AbSEEOrJ>; Sun, 5 May 2002 10:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSEEOrI>; Sun, 5 May 2002 10:47:08 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:41885 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S312920AbSEEOrH>; Sun, 5 May 2002 10:47:07 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200205051447.g45El62s000615@twopit.underworld>
Subject: Re: Linux 2.4.18 floppy driver EATS floppies
To: sony@faraday.ee.utt.ro (Sebastian Szonyi)
Date: Sun, 5 May 2002 15:47:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205051654260.10373-100000@faraday.ee.utt.ro> from "Sebastian Szonyi" at May 05, 2002 04:58:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I buyed once (a long time ago) a box with 10 floppies.
> Two died in the first day of use. From the others i still have some today.
> 
> I think the quality of the floppies (and other products) today isn't so
> high :-(

Well, that's one explanation. Curiously, I've just managed to salvage
my floppy disk. My initial attempt to run either "mkfs -t vfat" or "dd
if=mini.ima of=/dev/fd0" failed, so I ran "mkfs -t ext2" instead. Once
that ran successfully, I was able to dd the image again, and this time
it worked.

Sounds like either a floppy driver bug or a vfat filesystem bug to me.

Chris
