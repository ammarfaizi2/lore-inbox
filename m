Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbQLHV4J>; Fri, 8 Dec 2000 16:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132752AbQLHV4B>; Fri, 8 Dec 2000 16:56:01 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:50699 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S132517AbQLHVzv>;
	Fri, 8 Dec 2000 16:55:51 -0500
Date: Fri, 8 Dec 2000 23:24:56 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: linux-kernel@vger.kernel.org
Subject: Big IDE HD unclipping and IBM drive
Message-ID: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


I have an IBM drive, DTLA-307075 (75GB), and a bios that hangs with
large disks. I use a jumper to clip it to 32GB size, so the bios can
boot into linux. The problem is that WIN_READ_NATIVE_MAX returns 32GB,
and not the true size, and even trying to set the correct size with
WIN_SET_MAX fails. Is there a way to use this combination (Bios, HD,
Linux)?


-- 
Matan Ziv-Av.                         matan@svgalib.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
