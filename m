Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBUHJm>; Wed, 21 Feb 2001 02:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129127AbRBUHJc>; Wed, 21 Feb 2001 02:09:32 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:62727 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129098AbRBUHJY>;
	Wed, 21 Feb 2001 02:09:24 -0500
Date: Wed, 21 Feb 2001 08:09:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shane Wegner <shane@cm.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Message-ID: <20010221080919.A469@suse.cz>
In-Reply-To: <20010220134028.A5762@suse.cz> <20010220155927.A1543@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220155927.A1543@cm.nu>; from shane@cm.nu on Tue, Feb 20, 2001 at 03:59:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 03:59:27PM -0800, Shane Wegner wrote:

> > You wanted my VIA driver for 2.2. Here is a patch that brings the very
> > latest 4.2 driver to the 2.2 kernel. The patch is against the
> > 2.2.19-pre13 kernel plus yours 1221 ide patch.
> 
> This drivers breaks with my HP 8110 CD-R drive.  It's
> sitting on primary slave of a Via 686B controler.  When I
> try to do a hdparm -d1 -u1 -k1 /dev/hdb, the kernel locks
> up hard.  Not even an oops.  Reverting to the old driver
> works fine.

Don't do that. Use the kernel option to enable DMA instead.

Hmm, I'll have to look into this anyway - many users seem to do that and
it isn't as harmless as it looks (it worked by pure luck with the
previous version).

-- 
Vojtech Pavlik
SuSE Labs
