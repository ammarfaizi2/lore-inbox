Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286236AbRLTNWe>; Thu, 20 Dec 2001 08:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286237AbRLTNWY>; Thu, 20 Dec 2001 08:22:24 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:34826 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S286236AbRLTNWR>; Thu, 20 Dec 2001 08:22:17 -0500
Date: Thu, 20 Dec 2001 16:18:40 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - 32-bit IO support
Message-ID: <20011220161840.B5330@jurassic.park.msu.ru>
In-Reply-To: <20011218235024.N13126@flint.arm.linux.org.uk> <9vrmea$mef$1@cesium.transmeta.com> <20011219.213019.35013739.davem@redhat.com> <20011220093710.C29925@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011220093710.C29925@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Dec 20, 2001 at 09:37:10AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 09:37:10AM +0000, Russell King wrote:
> - setting the bridge and eepro100 up with 32-bit IO addresses which
>   correspond to the host MMIO region, it works perfectly.

Note that this wouldn't work with DEC 2105x PCI-PCI bridges, which
support only 16 bit I/O forwarding.
However, the patch is totally harmless for architectures limiting
I/O to 64K.

Ivan.
