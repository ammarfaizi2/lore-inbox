Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284540AbRLIVhv>; Sun, 9 Dec 2001 16:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284553AbRLIVhl>; Sun, 9 Dec 2001 16:37:41 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51913 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284540AbRLIVha>;
	Sun, 9 Dec 2001 16:37:30 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 9 Dec 2001 21:37:27 GMT
Message-Id: <UTC200112092137.VAA252458.aeb@cwi.nl>
To: kaih@khms.westfalen.de, linux-kernel@vger.kernel.org
Subject: Re: On re-working the major/minor system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: kaih@khms.westfalen.de (Kai Henningsen)

    > The C library, and the POSIX standard, etc, etc.

    I think you'll find that there is *NOTHING* in either the C standard,  
    POSIX, or the Austin future-{POSIX,UNIX} standard that knows about major  
    or minor numbers.

The Austin draft turned into POSIX 1003.1-2001 yesterday or so.

There is not much, but a few traces can be found.
For example, the pax archive format uses 8-byte devmajor and devminor fields.

(But to reassure others: no, this standard does not specify
major and minor in ls output, but just says
"If the file is a character special or block special file, the size of
 the file may be replaced with implementation-defined information
 associated with the device in question.")

Andries


