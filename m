Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbUAKBub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbUAKBub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:50:31 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:5014 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S265699AbUAKBu3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:50:29 -0500
From: sven kissner <sven.kissner@consistencies.net>
To: Andries.Brouwer@cwi.nl
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Date: Sun, 11 Jan 2004 02:53:03 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <UTC200401110028.i0B0SpL08329.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200401110028.i0B0SpL08329.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401110253.25040.sven.kissner@consistencies.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi andries, 

thanks for your reply.

On Sunday 11 January 2004 01:28, Andries.Brouwer@cwi.nl wrote:
> I have seen patches by Vojtech somewhere that already did this,
> but looking at current bk source it seems that they have not been
> applied yet.

where can i find those patches? kml?

> Anyway, I released kbd-1.10 last week or so, and it ignores the
> kernel NR_KEYS but tries to adapt dynamically to the kernel.
> It would not come with this error message, I suppose.

the message doesn't appear anymore, but installing is giving me the following:
<-- snip -->
Setting up kbd (1.10-1) ...
Looking for keymap to install:
de-latin1-nodeadkeys
cannot open file de-latin1-nodeadkeys
Loading /etc/console/boottime.kmap.gz
<-- snap -->
i guess i just screwed up the paths ;)

> : atkbd.c: Unknown key pressed (translated set 2, code 0x91 on
> : isa0060/serio0) atkbd.c: Unknown key released (translated set 2, code
> : 0x91 on isa0060/serio0) atkbd.c: Unknown key pressed (translated set 2,
> : code 0x92 on isa0060/serio0) atkbd.c: Unknown key released (translated
> : set 2, code 0x92 on isa0060/serio0)
>
> This is something different, a key without associated keycode.
> That is normal. If it really has high bit set it is a bit unusual.
> (What does showkey -s show?)

showkey -s is giving me exactly the same:
<-- snip -->
atkbd.c: Unknown key pressed (translated set 2, code 0x92 on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x92 on isa0060/serio0).
<-- snap -->

sven
- -- 
..never argue with idiots. they drag you down to their level and beat you with 
experience..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAAKySPV/e7f4i4AERAm0FAJ97N/CT3PfUcJZK2+4gXy7e3lDFgwCgl/T2
qRVMrl5ik2NZ3dtGdxounJQ=
=8I8H
-----END PGP SIGNATURE-----
