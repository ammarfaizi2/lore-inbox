Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbQKEUaS>; Sun, 5 Nov 2000 15:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQKEUaI>; Sun, 5 Nov 2000 15:30:08 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:44168 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129915AbQKEU3w>; Sun, 5 Nov 2000 15:29:52 -0500
Date: Sun, 5 Nov 2000 15:29:30 -0500
From: Ari Pollak <compwiz@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: scd/ide-scsi reporting size incorrectly
Message-ID: <20001105152930.A27643@darth.ns>
Mail-Followup-To: Ari Pollak <compwiz>, linux-kernel@vger.kernel.org
In-Reply-To: <20001105151725.A27278@darth.ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001105151725.A27278@darth.ns>; from compwiz on Sun, Nov 05, 2000 at 03:17:25PM -0500
X-Operating-System: Linux darth.ns 2.4.0-test10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm. I noticed the size reported is only the size of the last session,
not the total of all the sessions.

On Sun, Nov 05, 2000 at 03:17:25PM -0500, Ari Pollak wrote:
> Hey. I'm using an Acer 50X cdrom used with scd & ide-scsi emulation, and
> I just noticed that 'df' is reporting size incorrectly:
> /dev/scd1                85946     85946         0 100% /mnt/cdrom
> 
> Even though du clearly shows there is much more than 85 MB used:
> $ du -s /mnt/cdrom
> 359397	/mnt/cdrom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
