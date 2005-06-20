Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFTQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFTQXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFTQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:22:24 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:42995 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261377AbVFTQUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:20:11 -0400
Message-ID: <42B6EDE3.3040200@stesmi.com>
Date: Mon, 20 Jun 2005 18:25:07 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12 udev hangs at boot
References: <200506181332.25287.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <42B697B4.8060109@stesmi.com> <200506201413.22471.vda@ilport.com.ua>
In-Reply-To: <200506201413.22471.vda@ilport.com.ua>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Denis.

>>>After all, udev is tied to /sys layout which changes with kernel
>>>and also udev is vital for properly functioning boot process
>>
>>Not if you use a static /dev.
> 
> 
> Static /dev kind of defeats the purpose of udev.
> I do not want to go back to the days when I had tons of
> /dev/{h,s}d{a,b,c,d,e,f}{0,1,2,3,4,5,6,7,8,9} for every
> IDE and SCSI block device possible. Same for /dev/tty*.
> I want them appear on the fly, if/when hardware is present.

Of course it defeats the purpose of udev. That's not what I
was answering however. It was the blanket statement that
"udev is vital for properly functioning boot process" as
if udev was necessary. udev (for me) is a very fine tool
that serves very many purposes, however it is not vital.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCtu3jBrn2kJu9P78RAghtAJwN9Nv5jYuVqchP66I2fM3khizUNACfWfjI
bwUjbisvDWk6qCCaC13u1no=
=z8Tr
-----END PGP SIGNATURE-----
