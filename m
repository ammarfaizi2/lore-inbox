Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131996AbRBQUtq>; Sat, 17 Feb 2001 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132055AbRBQUtk>; Sat, 17 Feb 2001 15:49:40 -0500
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:8879 "EHLO
	nx5.HRZ.Uni-Dortmund.DE") by vger.kernel.org with ESMTP
	id <S131996AbRBQUtb>; Sat, 17 Feb 2001 15:49:31 -0500
Date: Fri, 16 Feb 2001 22:22:34 +0100 (CET)
From: Ingo Buescher <gallatin@cryogen.com>
X-X-Sender: <gallatin@nathan>
To: David Wood <dwood@templar.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: virtual console corruption (2.4.1/p4/radeon/XFree86
 4.0.2)
In-Reply-To: <Pine.LNX.4.30.0102141451320.9405-100000@mail.templar.com>
Message-ID: <Pine.LNX.4.31.0102162218370.5273-100000@nathan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 14 Feb 2001, David Wood wrote:

> Everything actually works rather well, with the exception that when I've
> started XFree86 a few times, coupled with switching virtual consoles, I
> get irretrievably "corrupted" text virtual consoles. The screen becomes
> garbled, sometimes quite colorful, cursor goes to the wrong place, text
> appears in odd locations or is not visible at all. Interestingly, the
> scrollback buffer allows me to scroll through the garble perfectly.
>
> The problem can only be fixed by rebooting.
>

You don't need to reboot. Just try:
echo  CTRL-V ESC-C RETURN

This should reset your console.

IB
- -- 
============================================================================
Ingo Buescher <gallatin@cryogen.com>
Fingerprint: A8D9 610F 175E 4B8D FDB7  6077 0878 5ADF DF00 C939
M$ Outlook, the software which made the "Good Times" email hoax a reality.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Made with pgp4pine 1.75

iD8DBQE6jZoeCHha398AyTkRAkP0AJ9a9+x0yhzQIi6BNAQWqrTwJQlxrgCcCQGJ
MGzgb5u9gI9dv+Jys/zPR24=
=iO+o
-----END PGP SIGNATURE-----


