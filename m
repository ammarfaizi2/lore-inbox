Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293478AbSCFLr4>; Wed, 6 Mar 2002 06:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSCFLrq>; Wed, 6 Mar 2002 06:47:46 -0500
Received: from ns.suse.de ([213.95.15.193]:64527 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293478AbSCFLrm>;
	Wed, 6 Mar 2002 06:47:42 -0500
Date: Wed, 6 Mar 2002 12:47:41 +0100
From: Dave Jones <davej@suse.de>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj3 - ide_modes.h
Message-ID: <20020306124741.J6531@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ben Clifford <benc@hawaga.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020306034355.A30476@suse.de> <Pine.LNX.4.33.0203052245290.3642-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203052245290.3642-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Tue, Mar 05, 2002 at 10:53:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 10:53:58PM -0800, Ben Clifford wrote:
 > in drivers/ide/ide_modes.h,
 > typedef ... ide_pio_timings_t;
 > is only defined #ifdef CONFIG_BLK_DEV_IDE_MODES.
 > But it is used in ide.c without any ifdefs around it, resulting in a
 > compile error.
 > In 2.5.5-dj2, this block was in ide_modes.h within the same #ifdef as the
 > typedef, but was moved by the -dj3 patch.

 It came from the 2.5.6pre2 merge. Hopefully the next round of Martins
 patches will fix that up.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
