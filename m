Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWHBVl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWHBVl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHBVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:41:29 -0400
Received: from mail.gmx.net ([213.165.64.21]:26845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932237AbWHBVl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:41:28 -0400
X-Authenticated: #5039886
Date: Wed, 2 Aug 2006 23:41:26 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: driver for thinkpad fingerprint sensor
Message-ID: <20060802214126.GA22928@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <20060802203925.GA13899@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060802203925.GA13899@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.02 22:39:25 +0200, Pavel Machek wrote:
> Hi!
> 
> Here's GPLed driver for thinkpad fingerprint sensor. It is in
> userspace -- for now, but it is so simple it could be easily moved
> into kernel (everything is done in hardware).
> 
> Questions are:
> 
> *) should it be kernel or userspace?
> 
> *) can someone test it/fix it on X41 and similar models? It works okay
> on x60.

I just gave it a try on my T43 (2668-WUM), works well if I swipe my
finger correctly, ends up in a loop otherwise (at least I guess it's bad
finger swiping).

Some outputs from thinkfinger follow.

HTH
Björn


Failed generating result.bir:
----
Device found.
Initializing...
*** Did not write whole 120 bytes
Preparing enroll...
*** Wanted 0x40 bytes, got 52
Ready.
Please swipe your finger
Please swipe your finger
Please swipe your finger
Processing
Please swipe your finger 1 rd time
Please swipe your finger 1 rd time
Please swipe your finger 1 rd time
Processing
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Scanning: 0b
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Scanning: 08
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Processing
...and the result is:
Fingerprint follows?
*** Wanted 0x40 bytes, got -110
Fingerprint follows?
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Fingerprint follows?
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Read: 
Write: 43 69 61 6f 00 60 08 28 05 00 00 00 00 30 01 49 6b 
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Read: 
Write: 43 69 61 6f 00 70 08 28 05 00 00 00 00 30 01 df ff 
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Fingerprint follows?



Succeeded generating bir:
----
Device found.
Initializing...
*** Did not write whole 120 bytes
Preparing enroll...
*** Wanted 0x40 bytes, got 52
Ready.
Please swipe your finger
Please swipe your finger
Please swipe your finger
Processing
Please swipe your finger 1 rd time
Please swipe your finger 1 rd time
Please swipe your finger 1 rd time
Processing
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Scanning: 08
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Please swipe your finger 2 rd time
Processing
...and the result is:
Fingerprint is:
birfile is 4
Read: 43 69 61 6f 00 70 cb 28 c8 00 00 00 02 12 ff ff ff ff c0 00 00 00 01 04 12 00 00 00 fe 04 08 00 00 00 41 50 52 39 08 01 00 5c 00 00 ff 26 01 54 3e 33 08 00 00 00 80 4a f4 0f ac c4 44 11 4e c8 
Write: 43 69 61 6f 00 80 08 28 05 00 00 00 00 30 01 6a c4 
*** Did not write whole 17 bytes
Writing fingerprint (64 bytes)
Read: 04 1f 99 c8 14 01 c2 d0 b8 02 be f0 64 12 71 38 f5 0e 52 4c 35 0d 9a 6a 89 11 b9 74 d9 04 8d 8a b5 0f 7e 92 c5 00 6d b4 e9 09 84 c8 55 06 8d d4 a5 05 71 dc c9 07 94 10 fa 06 9a 34 18 11 b0 44 
Write: 43 69 61 6f 00 60 08 28 05 00 00 00 00 30 01 49 6b 
*** Did not write whole 17 bytes
Writing fingerprint (64 bytes)
Read: e8 12 40 60 64 1f 51 94 e4 0e dc c4 84 12 39 aa e9 0a 39 aa 49 1c 7e c4 69 2d 92 c4 79 32 52 cc b5 0a 84 d0 29 26 7e 10 1a 07 51 1c 66 09 dd 32 86 16 6d 3c 4a 08 5e 40 f6 08 bc 40 0a 06 79 50 
Write: 43 69 61 6f 00 70 08 28 05 00 00 00 00 30 01 df ff 
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got 20
Writing fingerprint (20 bytes)
Read: b6 07 4b 3a 65 1e 6e 9c b5 5e 7f 0a ba 06 00 00 00 00 d9 d6 
Write: 43 69 61 6f 00 80 08 28 05 00 00 00 00 30 01 6a c4 
CIAO: end of finerprint
Communication failed.



Matching fingerprint:
----
Device found.
Initializing...
*** Did not write whole 120 bytes
Preparing verify...
(Fingerprint is 194 bytes)
*** Wanted 0x40 bytes, got 52
Read: 02 00 00 00 00 00 01 00 64 00 02 00 01 30 01 00 00 00 01 00 00 00 00 00 00 00 01 00 01 00 02 00 f4 01 96 00 0b 00 f4 01 00 00 00 00 00 00 00 00 00 00 da 67 
Write: 43 69 61 6f 00 50 df 28 dc 00 00 00 03 02 00 00 00 00 00 00 00 00 00 00 00 00 c0 d4 01 00 20 00 00 00 03 00 00 00 c0 00 00 00 01 04 12 00 00 00 fe 04 08 00 00 00 41 50 52 39 08 01 00 5c 00 00 ff 26 01 54 3e 33 08 00 00 00 80 4a f4 0f ac c4 44 11 4e c8 04 1f 99 c8 14 01 c2 d0 b8 02 be f0 64 12 71 38 f5 0e 52 4c 35 0d 9a 6a 89 11 b9 74 d9 04 8d 8a b5 0f 7e 92 c5 00 6d b4 e9 09 84 c8 55 06 8d d4 a5 05 71 dc c9 07 94 10 fa 06 9a 34 18 11 b0 44 e8 12 40 60 64 1f 51 94 e4 0e dc c4 84 12 39 aa e9 0a 39 aa 49 1c 7e c4 69 2d 92 c4 79 32 52 cc b5 0a 84 d0 29 26 7e 10 1a 07 51 1c 66 09 dd 32 86 16 6d 3c 4a 08 5e 40 f6 08 bc 40 0a 06 79 50 b6 07 4b 3a 65 1e 6e 9c b5 5e 7f 0a ba 06 00 00 00 00 4f 47 
Ready.
Please swipe your finger
Please swipe your finger
Processing
...and the result is:
Fingerprint matches.



Non-matching fingerprint:
----
Device found.
Initializing...
*** Did not write whole 120 bytes
Preparing verify...
(Fingerprint is 194 bytes)
*** Wanted 0x40 bytes, got 52
Read: 02 00 00 00 00 00 01 00 64 00 02 00 01 30 01 00 00 00 01 00 00 00 00 00 00 00 01 00 01 00 02 00 f4 01 96 00 0b 00 f4 01 00 00 00 00 00 00 00 00 00 00 da 67 
Write: 43 69 61 6f 00 50 df 28 dc 00 00 00 03 02 00 00 00 00 00 00 00 00 00 00 00 00 c0 d4 01 00 20 00 00 00 03 00 00 00 c0 00 00 00 01 04 12 00 00 00 fe 04 08 00 00 00 41 50 52 39 08 01 00 5c 00 00 ff 26 01 54 3e 33 08 00 00 00 80 4a f4 0f ac c4 44 11 4e c8 04 1f 99 c8 14 01 c2 d0 b8 02 be f0 64 12 71 38 f5 0e 52 4c 35 0d 9a 6a 89 11 b9 74 d9 04 8d 8a b5 0f 7e 92 c5 00 6d b4 e9 09 84 c8 55 06 8d d4 a5 05 71 dc c9 07 94 10 fa 06 9a 34 18 11 b0 44 e8 12 40 60 64 1f 51 94 e4 0e dc c4 84 12 39 aa e9 0a 39 aa 49 1c 7e c4 69 2d 92 c4 79 32 52 cc b5 0a 84 d0 29 26 7e 10 1a 07 51 1c 66 09 dd 32 86 16 6d 3c 4a 08 5e 40 f6 08 bc 40 0a 06 79 50 b6 07 4b 3a 65 1e 6e 9c b5 5e 7f 0a ba 06 00 00 00 00 4f 47 
Ready.
Please swipe your finger
Please swipe your finger
Please swipe your finger
Processing
...and the result is:
Fingerprint did not match. (2)
Read: 43 69 61 6f 00 70 0b 28 08 00 00 00 03 12 00 00 00 00 bd b3 00 00 00 00 00 00 00 70 0b 5e 7f 0a ba 06 00 00 00 00 a3 92 49 1c 7e c4 69 2d 92 c4 79 32 52 cc b5 0a 84 d0 29 26 7e 10 1a 07 51 1c 
Write: 43 69 61 6f 00 80 08 28 05 00 00 00 00 30 01 6a c4 
Communication failed.



Failure while checking the fingerprint:
----
Device found.
Initializing...
*** Did not write whole 120 bytes
Preparing verify...
(Fingerprint is 194 bytes)
*** Wanted 0x40 bytes, got 52
Read: 02 00 00 00 00 00 01 00 64 00 02 00 01 30 01 00 00 00 01 00 00 00 00 00 00 00 01 00 01 00 02 00 f4 01 96 00 0b 00 f4 01 00 00 00 00 00 00 00 00 00 00 da 67 
Write: 43 69 61 6f 00 50 df 28 dc 00 00 00 03 02 00 00 00 00 00 00 00 00 00 00 00 00 c0 d4 01 00 20 00 00 00 03 00 00 00 c0 00 00 00 01 04 12 00 00 00 fe 04 08 00 00 00 41 50 52 39 08 01 00 5c 00 00 ff 26 01 54 3e 33 08 00 00 00 80 4a f4 0f ac c4 44 11 4e c8 04 1f 99 c8 14 01 c2 d0 b8 02 be f0 64 12 71 38 f5 0e 52 4c 35 0d 9a 6a 89 11 b9 74 d9 04 8d 8a b5 0f 7e 92 c5 00 6d b4 e9 09 84 c8 55 06 8d d4 a5 05 71 dc c9 07 94 10 fa 06 9a 34 18 11 b0 44 e8 12 40 60 64 1f 51 94 e4 0e dc c4 84 12 39 aa e9 0a 39 aa 49 1c 7e c4 69 2d 92 c4 79 32 52 cc b5 0a 84 d0 29 26 7e 10 1a 07 51 1c 66 09 dd 32 86 16 6d 3c 4a 08 5e 40 f6 08 bc 40 0a 06 79 50 b6 07 4b 3a 65 1e 6e 9c b5 5e 7f 0a ba 06 00 00 00 00 4f 47 
Ready.
Please swipe your finger
Please swipe your finger
Please swipe your finger
Please swipe your finger
Fingerprint follows?
*** Wanted 0x40 bytes, got -110
Fingerprint follows?
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Fingerprint follows?
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Read: 
Write: 43 69 61 6f 00 70 08 28 05 00 00 00 00 30 01 df ff 
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Fingerprint follows?
*** Did not write whole 17 bytes
*** Wanted 0x40 bytes, got -110
Fingerprint follows?
