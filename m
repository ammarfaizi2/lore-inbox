Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267920AbUHPT4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267920AbUHPT4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUHPT4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:56:46 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:23721 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S267920AbUHPTz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:55:29 -0400
Subject: Re: Packet writing problems
From: Frediano Ziglio <freddyz77@tin.it>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3657iq4rk.fsf@telia.com>
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	 <m3657iq4rk.fsf@telia.com>
Content-Type: text/plain
Message-Id: <1092686149.4338.1.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Aug 2004 21:55:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il lun, 2004-08-16 alle 21:09, Peter Osterlund ha scritto:
...
> 
> The second problem is in the dvdrw-support patch in the -mm kernel.
> (This patch is also included in the patch you are using.)
> 
> The problem is that some drives fail the "GET CONFIGURATION" command
> when asked to only return 8 bytes. This happens for example on my
> drive, which is identified as:
> 
>         hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
> 
> Since the cdrom_mmc3_profile() function already allocates 32 bytes for
> the reply buffer, this patch is enough to make the command succeed on
> my drive.
> 

I'm forgetting... 

mounting devices it reports that disk was CD-RW and speed was 15
(DVD-RW) and 31 (DVD+RW).

freddy77


