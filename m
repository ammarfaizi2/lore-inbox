Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbSLTKSU>; Fri, 20 Dec 2002 05:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267767AbSLTKSU>; Fri, 20 Dec 2002 05:18:20 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29858 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267765AbSLTKST>;
	Fri, 20 Dec 2002 05:18:19 -0500
Date: Fri, 20 Dec 2002 10:25:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52: agp, drm, i810 problem
Message-ID: <20021220102541.GD24782@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Felix Seeger <felix.seeger@gmx.de>, linux-kernel@vger.kernel.org
References: <200212200034.16969.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212200034.16969.felix.seeger@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 12:34:12AM +0100, Felix Seeger wrote:

 > I am running 2.5.52 (I must say that it is the best kernel I ever had, first 
 > time acpi and sony jog dial are working, great)
 > But I have some agp problems at the moment:
 > 
 > $ modprobe i810
 > FATAL: Error inserting i810 
 > (/lib/modules/2.5.52/kernel/drivers/char/drm/i810.ko): Cannot allocate memory

That one was my fault. I think I may have this fixed now.
bk://linux-dj.bkbits.net/agpgart has a bunch of fixes for numerous agp
related problems. I'll generate a GNU patch later today, and ask
Linus to pull what I have so far.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
