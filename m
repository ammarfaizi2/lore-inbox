Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLLVjW>; Tue, 12 Dec 2000 16:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbQLLVjG>; Tue, 12 Dec 2000 16:39:06 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:46843 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129429AbQLLVjB>; Tue, 12 Dec 2000 16:39:01 -0500
Date: Tue, 12 Dec 2000 13:08:03 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Matan Ziv-Av <matan@svgalib.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Big IDE HD unclipping and IBM drive
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>
Message-ID: <Pine.LNX.4.21.0012121307250.6171-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yeah, get yourself one of those nifty add-in IDE controllers that CAN see
drives greater than 32GB. S'What I did and it works fine.

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
> 
> 
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
