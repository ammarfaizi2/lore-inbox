Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVCZKTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVCZKTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVCZKTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:19:48 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:43273 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261845AbVCZKTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:19:46 -0500
Date: Sat, 26 Mar 2005 11:19:45 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.6.12-rc1-mm3, sound card lost id
Message-Id: <20050326111945.5eb58343.khali@linux-fr.org>
In-Reply-To: <20050325002154.335c6b0b.akpm@osdl.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/
> (...)
>  bk-alsa.patch

This one made /proc/asound/card0/id change from "Live" to "Unknown" on
one of my systems, preventing alsatcl from properly restoring my mixer
settings.

I guess this wasn't exactly expected?

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 48, IRQ 5
        I/O ports at 8800 [size=32]

Class:     0401
Device:    1102:0002
Subsystem: 1102:8027

Thanks,
-- 
Jean Delvare
