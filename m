Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbULKTHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbULKTHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbULKTHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:07:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43429 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261986AbULKTHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:07:34 -0500
Date: Sat, 11 Dec 2004 20:07:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
cc: Simos Xenitellis <simos74@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Improved console UTF-8 support for the Linux kernel?
In-Reply-To: <20041211173032.GA13208@fargo>
Message-ID: <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The current UTF-8 keyboard input (for the console) of the Linux kernel
>> does not support  "composing" or writing characters with accents.

That's weird, because "ö" (LATIN O WITH DIAERESIS) -- which clearly lies
outside the 7-bit range, is working on my system without myself poking the
kernel. Both hitting the key or using compose mode. This also applies to
A-with-DIAERESIS, U-with-DIAERESIS, sharp german S, but does not for anything
else, e.g. compose-'-e to generate E with accent aigu.

>Yes, i recently find it out when trying to switch all my system to
>UTF-8. But the patch from Chris you mention below works very well
>for me (and for anybody that needs to type compose characters for
>languages based in the latin1 encoding i guess).
>
>> Is there an interest for re-submission of mentioned patches for
>> inclusion in the kernel (yeah, provided coding style is "normalised")?
>
>At least, I am _really_ interested :)

So am I. I have to use xterm for anything fancy now...
(especially for the even-more fancy stuff that begins at three-byte UTF8
sequences, such as Japanese :-)



Jan Engelhardt
-- 
ENOSPC
