Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287231AbSACMjb>; Thu, 3 Jan 2002 07:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287229AbSACMjV>; Thu, 3 Jan 2002 07:39:21 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:13073 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S287231AbSACMjO>; Thu, 3 Jan 2002 07:39:14 -0500
Date: Thu, 3 Jan 2002 13:39:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: cs@zip.com.au, Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103133912.B17280@suse.cz>
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au> <E16M75s-0008Bz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16M75s-0008Bz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 03, 2002 at 12:35:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:35:36PM +0000, Alan Cox wrote:

> > Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
> > with the kernel; in-kernel code is fundamentally in sync.
> 
> Disagree. Its reading BIOS tables not poking at kernel internals

It's still not very nice for userspace apps to touch hardware directly,
even if it's just BIOS memory ...

-- 
Vojtech Pavlik
SuSE Labs
