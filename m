Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSE3Cn5>; Wed, 29 May 2002 22:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSE3Cn4>; Wed, 29 May 2002 22:43:56 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:46451 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S316214AbSE3Cnu>; Wed, 29 May 2002 22:43:50 -0400
Date: Wed, 29 May 2002 22:42:58 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
Message-ID: <20020529224258.A20805@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	andre@linux-ide.org
In-Reply-To: <20020529172425.A15749@shookay.newview.com> <20020529.185933.103256606.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It fixed it:

hdc: Maxtor 4G120J6, ATA DISK drive
hdd: CRD-8322B, ATAPI CD/DVD-ROM drive
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 4,7e0
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 4,7e0 (shared with ide0)
hda: 17803297 sectors (9115 MB) w/2048KiB Cache, CHS=17662/16/63, (U)DMA
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/255/63, (U)DMA

Thanks David!

On Wed, May 29, 2002 at 06:59:33PM -0700, David S. Miller wrote:
> 
> Hey Mathieu, give this patch a spin.  It makes it through
> the compiler, but more interesting is if it fixes your
> problem or not :-)

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
