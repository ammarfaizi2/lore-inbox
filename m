Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKU5F>; Thu, 11 Jan 2001 15:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbRAKU4z>; Thu, 11 Jan 2001 15:56:55 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:7955 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129631AbRAKU4k>; Thu, 11 Jan 2001 15:56:40 -0500
Message-ID: <3A5E1E0D.B420A045@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 21:56:45 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <Pine.GSO.4.21.0101111337250.17363-100000@weyl.math.psu.edu> <3A5E0886.4389692E@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> The very strange stuff is umount at reboot:
> 
> umount: none busy - remounted read-only
> umount: /: device is busy
> Remounting root-filesystem read-only
> mount: / is busy
> Rebooting.

I just noticed another strange effect:

ps uxa misses a couple dozen processes. Effectively I'm seeing
only the kernel processes, all gettys, rpc.portmap, bash and ps.
All other processes, all daemons etc. are invisible. If I kill
portmap another process becomes visible.

I've checked a couple of other machines, different setups etc.
all with -ac6 and all show this behavior - also the umount stuff.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
