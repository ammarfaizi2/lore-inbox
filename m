Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUAKIZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUAKIZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:25:21 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:36521 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S265805AbUAKIZQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:25:16 -0500
From: sven kissner <sven.kissner@consistencies.net>
To: Andries.Brouwer@cwi.nl
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Date: Sun, 11 Jan 2004 09:27:54 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <UTC200401110405.i0B45q016858.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200401110405.i0B45q016858.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401110928.13789.sven.kissner@consistencies.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 January 2004 05:05, Andries.Brouwer@cwi.nl wrote:
>
>     > : atkbd.c: Unknown key pressed (translated set 2, code 0x91 on
>     >
>     > This is something different, a key without associated keycode.
>     > That is normal. If it really has high bit set it is a bit unusual.
>     > (What does showkey -s show?)
>
>     showkey -s is giving me exactly the same:
>     <-- snip -->
>     atkbd.c: Unknown key pressed
>     <-- snap -->
>
> That is a kernel message, not showkey output.
> (BTW - which kernel precisely? The message is not the 2.6.0 one.)
> Maybe showkey -s never sees them?

i'm running a vanilla 2.6.1-kernel, without any additional patches. you're 
right about the message, showkey is exiting after 10s, even if i keep one of 
the 'problematic' keys pressed.. 

sven
- -- 
..never argue with idiots. they drag you down to their level and beat you with 
experience..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAAQkbPV/e7f4i4AERAtvlAJ9ZuzhypFDzcIz5aUsxgqmPXWuhXACdFTyd
KDY8eZYaEZ44u0se4/nWmcQ=
=Qryn
-----END PGP SIGNATURE-----
