Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKQIEJ>; Fri, 17 Nov 2000 03:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKQIEB>; Fri, 17 Nov 2000 03:04:01 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:48900
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129111AbQKQID3>; Fri, 17 Nov 2000 03:03:29 -0500
Date: Fri, 17 Nov 2000 20:33:25 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6
Message-ID: <20001117203325.A15841@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 16, 2000 at 06:33:11PM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 06:33:11PM -0800, Linus Torvalds wrote:
    
    The log-file says it all..
    
    		Linus
    
    -----
    
     - pre6:
        - Intel: start to add Pentium IV specific stuff (128-byte cacheline
          etc)
        - David Miller: search-and-destroy places that forget to mark us
          running after removing us from a wait-queue.
        - me: NFS client write-back ref-counting SMP instability.
        - me: fix up non-exclusive waiters
        - Trond Myklebust: Be more careful about SMP in NFS and RPC code
        - Trond Myklebust: inode attribute update race fix
        - Charles White: don't do unaligned accesses in cpqarray driver.
        - Jeff Garzik: continued driver cleanup and fixes
        - Peter Anvin: integrate more of the Intel patches.
        - Robert Love: add i815 signature to the intel AGP support
        - Rik Faith: DRM update to make it easier to sync up 2.2.x
        - David Woodhouse: make old 16-bit pcmcia controllers work
          again (ie i82365 and TCIC)

There are 'hotplug' additions -- these now mean the networking code
won't build without "CONFIG_HOTPLUG=y".

What is the correct fix here; fix the networking code or just take
this option out and ensure hotplug functionality is no longer
compile-time dependent (always compiled in) ?


  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
