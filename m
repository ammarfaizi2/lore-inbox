Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132952AbQLHWC7>; Fri, 8 Dec 2000 17:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132857AbQLHWCu>; Fri, 8 Dec 2000 17:02:50 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:20997
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132952AbQLHWCm>; Fri, 8 Dec 2000 17:02:42 -0500
Date: Fri, 8 Dec 2000 13:27:59 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Matan Ziv-Av <matan@svgalib.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Big IDE HD unclipping and IBM drive
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>
Message-ID: <Pine.LNX.4.10.10012081327210.3346-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Matan Ziv-Av wrote:

> 
> Hi,
> 
> 
> I have an IBM drive, DTLA-307075 (75GB), and a bios that hangs with
> large disks. I use a jumper to clip it to 32GB size, so the bios can
> boot into linux. The problem is that WIN_READ_NATIVE_MAX returns 32GB,
> and not the true size, and even trying to set the correct size with
> WIN_SET_MAX fails. Is there a way to use this combination (Bios, HD,
> Linux)?


Yep you have to use code/patches that are not in the standard kernel.
Which kernel are you using?

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
