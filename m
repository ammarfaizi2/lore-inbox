Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282183AbRLDGUi>; Tue, 4 Dec 2001 01:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282203AbRLDGU2>; Tue, 4 Dec 2001 01:20:28 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:7176 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S282183AbRLDGUR>; Tue, 4 Dec 2001 01:20:17 -0500
Date: Tue, 4 Dec 2001 00:19:57 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: MIDN Sean Jones <m053546@usna.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bugs
Message-ID: <20011204001957.A31869@asooo.flowerfire.com>
In-Reply-To: <1007332194.11790.0.camel@Eagle.usna.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1007332194.11790.0.camel@Eagle.usna.edu>; from m053546@usna.edu on Sun, Dec 02, 2001 at 05:29:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a patch sent a month or so ago that removed disable_ida_dma.
I usually apply cleanups like this, but it's a toss-up whether it's
worth it.  Maybe these functions should be removed from 2.5 until
someone complains.

-- 
Ken.
brownfld@irridia.com

On Sun, Dec 02, 2001 at 05:29:52PM -0500, MIDN Sean Jones wrote:
| I was looking for code to cleanup and found these warnings:
| 
| (from 2.4.17-pre2)
| 
| dmi_scan.c:195: warning: `disable_ide_dma' defined but not used
| agpgart_be.c:524: warning: `agp_generic_create_gatt_table' defined but
| not used
| agpgart_be.c:652: warning: `agp_generic_free_gatt_table' defined but not
| used
| agpgart_be.c:700: warning: `agp_generic_insert_memory' defined but not
| used
| agpgart_be.c:758: warning: `agp_generic_remove_memory' defined but not
| used
| parport_pc.c:1784: warning: `parport_ECP_supported' defined but not used
| 
| Are these functions supposed to be there or are they leftovers from
| previous modifications.
| 
| Thanks,
| 
| Sean Jones
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
