Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313560AbSDHGIG>; Mon, 8 Apr 2002 02:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSDHGIF>; Mon, 8 Apr 2002 02:08:05 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:12678 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S313560AbSDHGIE>;
	Mon, 8 Apr 2002 02:08:04 -0400
Date: Mon, 8 Apr 2002 15:07:23 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: marcelo@conectiva.com.br
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Extraversion in System.map?
In-Reply-To: <20020405060509.GB30807@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0204081502180.548-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of my penance for using the wrong System.map file in the
readprofile data I sent out, I have prepared a patch to readprofile
that makes it check the version of the file against the kernel.

Much to my dismay, the extraversion code ('-pre6' for example) does
not appear to be anywhere in System.map.  Or am I wrong?  If not, why
not, and can this be fixed?  After all, symbols can and do change
between -pre versions.

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

