Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSKBQiF>; Sat, 2 Nov 2002 11:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbSKBQiF>; Sat, 2 Nov 2002 11:38:05 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:720 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id <S261300AbSKBQiE>;
	Sat, 2 Nov 2002 11:38:04 -0500
Date: Sat, 2 Nov 2002 10:12:39 -0700
From: Matt Porter <porter@cox.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, hpa@zytor.com, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
Message-ID: <20021102101239.A9442@home.com>
References: <3DC38939.90001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DC38939.90001@pobox.com>; from jgarzik@pobox.com on Sat, Nov 02, 2002 at 03:13:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 03:13:45AM -0500, Jeff Garzik wrote:
> #4 - move mounting root to userspace
> 
> People probably breathed a sigh of relief at patch #3, they will heave a 
> bigger sigh for this patch :)   This moves mounting of the root 
> filesystem to early userspace, including getting rid of 
> NFSroot/bootp/dhcp code in the kernel.

For those of us who only develop on nfsroot-based systems, does this
step include adding userspace network interface configuration and
bootp/dhcp client functionality to kinit?  I want to assume that
"getting rid of NFSroot/bootp/dhcp" means moving that particular
functionality as part of this step.  Just wondering what the
short-term impact will be on the poor embedded guys. :)

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
