Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbRGFMik>; Fri, 6 Jul 2001 08:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbRGFMib>; Fri, 6 Jul 2001 08:38:31 -0400
Received: from eden.ispol.com ([206.239.103.254]:25865 "EHLO eden.ispol.com")
	by vger.kernel.org with ESMTP id <S266654AbRGFMiP>;
	Fri, 6 Jul 2001 08:38:15 -0400
Date: Fri, 6 Jul 2001 08:38:12 -0400 (EDT)
From: "Gregory (Grisha) Trubetskoy" <grisha@ispol.com>
X-X-Sender: <grisha@localhost>
To: <linux-kernel@vger.kernel.org>
Subject: reading/writing CMOS beyond 256 bytes?
Message-ID: <Pine.BSF.4.32.0107060829460.47924-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sorry this may be OT:

I wrote a little brogram to read/write the CMOS settings to a file on an
Intel L440GX motherboard using the outb() to ports 0x70 and 0x71. The idea
is to save the BIOS settings I like and then be able to blast them from
within Linux without having to tinker with BIOS setup.

Unfortunately, it seems that some settings are not in the 128 (or 256)
bytes accessible this way, so they must be stored elsewhere.

Does anyone know where I should look for the remaining parts of CMOS
(short of having to sign some NDA with Intel?)?

Any advice/pointers is highly appreciated,

Grisha


