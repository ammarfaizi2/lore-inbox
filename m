Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbRG2KsE>; Sun, 29 Jul 2001 06:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267928AbRG2Kry>; Sun, 29 Jul 2001 06:47:54 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:16156 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267930AbRG2Krn>; Sun, 29 Jul 2001 06:47:43 -0400
Posted-Date: Sun, 29 Jul 2001 10:47:36 GMT
Message-ID: <00e101c1181b$e1c43380$5ffca8c0@UFP.CX>
From: "Riley Williams" <rhw@@MemAlpha.cx>
To: "Eric S Raymond" <esr@thyrsus.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <E14qaeC-0001DZ-00@the-village.bc.nu>
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Date: Sun, 29 Jul 2001 11:47:00 +0100
Organization: Memory Alpha
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00DE_01C11824.3404BEA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_00DE_01C11824.3404BEA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Alan, Eric.

>> That's the main thing I'm after right now -- I want to cut down on
>> the false positives in my orphaned-symbol reports so that the
actual
>> bugs will stand out.

> Teach it to read a 'symbolstoignore' file.
>
> Part of the problem you are hitting right now is that most
architectures are
> not yet fully in sync with 2.4 nor likely to all be for another few
iterations.

Not sure if it's relevant, but, I've enclosed (1) a bash script that
produces an analysis of the CONFIG_ variables in a specified Linux
kernel source tree, and (2) the results from running that on the 2.4.5
tree. It analyses all files matching '*.?' and '[Cc]onfig.in' in the
specified tree, and reports on the results by summarising both how
many times each CONFIG_* variable is used total, which files it is
used in, and how many times it is used in each file.

Best wishes from Riley.


------=_NextPart_000_00DE_01C11824.3404BEA0
Content-Type: application/octet-stream;
	name="allgrep.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="allgrep.gz"

H4sICMF0SzsCA2FsbGdyZXAAnVLRbtMwFH2Ov+IsdHhDctMiVQiNgKrB0KRqlVDhgaZMruO0loJd
7GRoUP4dJ07DKiYecB7ie319zj3n+slJslY6WXO3JaSotaiU0SiN4JU8O8dPAr8KpXPEg3EMVt3v
JApkZ2Caf5Wgz4ZvKJg5hMtLsTK6UJuh0hTZOfn1AHYjqztue1gnc1CXLL+M2MvbKfvM2Y9VgmRD
8apli6KMRHtUFsyBNl+madRli42VO1zOb66u398+wuJ6mkZMiavr2TvSx5UMevZwxlZghd9936pS
wkqet8W4QG5ItLNKVwXoKXsxcZml/l5zGuP10+ckClx9roPbo9bqG5hoEq3IdJCCdlU03dC2kdxo
edR5qfQf06XYGqT/uTyxqL2uNcZsMD4i2VkjpHvMHsxnb1NK8Wn6IfQnRcmtBFPe5483Cyzmi+ks
HQUbO5v/6WO45vEeOqoKLP0tn41xkvqdp42xukC1lZpEDXZbwvRfZ1HjECYjv+vnUsMIUVvLtZcF
U+DUZdo/FAzadtEQBdRChX8jM/CH+CAragp63EmNFsoDBRnt9I4GJ3IktbOJs4J0th7sqGR4Ycx7
pPi6lEOueXnvlCO/AYntmtFzAwAA

------=_NextPart_000_00DE_01C11824.3404BEA0--

