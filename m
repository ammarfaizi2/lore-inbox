Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754103AbWKLQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbWKLQrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 11:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbWKLQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 11:47:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40713 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1754103AbWKLQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 11:47:12 -0500
Date: Sun, 12 Nov 2006 17:47:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-ID: <20061112164716.GB3382@stusta.de>
References: <20061111100038.6277efd4.akpm@osdl.org> <1163340998.3293.131.camel@laptopd505.fenrus.org> <20061112152154.GA3382@stusta.de> <200611121059.55454.diablod3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611121059.55454.diablod3@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 10:59:55AM -0500, Patrick McFarland wrote:
>...
> Socket A CPUs are also ungodly common. They're as common as slot 1/socket 370 
> Pentium 3s, and, at least with my old P3 board, trying to use APIC on UP 
> caused lockups. My Duron 1ghz laptop also does the same thing. (Booting 
> either with noapic fixes it).
>...

It might depend on the age of your computer.

Microsoft mandates the presence of an APIC implemented per MADT and all 
hardware interrupts connected to an IOAPIC for all servers and desktops 
with a "Designed for Windows XP" sticker.

This implies more or less that a working APIC is present in all
non-laptop x86 UP systems manufactured during the last 5 years.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

