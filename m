Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUAMLwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUAMLwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:52:22 -0500
Received: from mail.poliba.it ([193.204.49.50]:50612 "EHLO mail.poliba.it")
	by vger.kernel.org with ESMTP id S264261AbUAMLwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:52:17 -0500
Date: Tue, 13 Jan 2004 12:45:49 +0100
From: "Angelo Dell'Aera" <buffer@sniffo.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix a drivers/char/isicom.c compile warning
Message-Id: <20040113124549.229429b3.buffer@sniffo.org>
In-Reply-To: <20040113003828.GO18853@conectiva.com.br>
References: <20040113000055.GU9677@fs.tum.de>
	<20040113001746.GN18853@conectiva.com.br>
	<20040113002318.GV9677@fs.tum.de>
	<20040113003828.GO18853@conectiva.com.br>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 12 Jan 2004 22:38:28 -0200
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

>> I thought about it, but I wasn't sure whether changing a driver to be 
>> more readable in _one_ place and making the code there different from 
>> the coding style used in the rest of the driver is really an 
>> improvement (and no, I don't want to clean the whole driver...)?
>
>Humm, IMHO it is better to get it with mixed style as long as the changes that
>"break" the style are for the correct style, but this, of course, for purely
>unmaintained stuff, like... isicom.c :-) For maintained stuff it becomes a
>pain in the ass for the maintainer, that should try to follow CodingStyle, but
>as we know, not always do.

I started cleaning isicom.c in such a way as to be more "CodingStyle 
compliant" but it's a hard pain... the fix from Adrian is still in.
Hope to release it in a reasonable time.

Regards. 

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAA9ptpONIzxnBXKIRAhlqAJ9jefAfKxXeLJYb0SCpqBp8EGfN0QCfdvuo
ToB15Ba8cV73AMOpbcjAe4I=
=fXgy
-----END PGP SIGNATURE-----
