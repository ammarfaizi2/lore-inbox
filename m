Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRDUL7L>; Sat, 21 Apr 2001 07:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDUL6v>; Sat, 21 Apr 2001 07:58:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5131 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132576AbRDUL6p>; Sat, 21 Apr 2001 07:58:45 -0400
Subject: Re: A question about MMX.
To: lk@aniela.eu.org
Date: Sat, 21 Apr 2001 12:59:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104211353450.14048-100000@ns1.aniela.eu.org> from "lk@aniela.eu.org" at Apr 21, 2001 01:55:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qw2g-0003WD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a Intel Pentium MMX machine and it acts as a mailserver, webserver,
> ftp and I use X on it. I would like to know if the MMX instructions are
> used by the kernel in this operations or not (networking, X etc.).

In almost all cases - no. The MMX instructions are mostly not useful. A few
graphics operations benefit from them such as mpeg players but that is about
it.

On the AMD and Cyrix machines 3Dnow is used extensively by Mesa (3D) and by
many of the mp3 players. The winchip and athlon kernels also use mmx for
block copies but this isnt a win in the pentium case.

