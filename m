Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282244AbRK2BIj>; Wed, 28 Nov 2001 20:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282243AbRK2BHz>; Wed, 28 Nov 2001 20:07:55 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:49412 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282242AbRK2BHv>;
	Wed, 28 Nov 2001 20:07:51 -0500
Date: Wed, 28 Nov 2001 17:07:49 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for drivers/char/pc_keyb.c in 2.5.1-pre3
Message-ID: <20011128170748.A2762@kroah.com>
In-Reply-To: <20011128163810.C2512@kroah.com> <E169FUY-0006k8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E169FUY-0006k8-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 31 Oct 2001 22:58:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 12:55:54AM +0000, Alan Cox wrote:
> This is the diff I'm using. It
> 
> -	Fixes the initrd lock
> -	Fixes keyboard (as with Greg but with the formatting unmangled too)
> -	Fixes wdt_pci (bitops on it)
> -	Makes wdt use the same locking as wdt_pci
> -	Returns pc110pad to the coding style and redoes the locks to
> 	kill old style locking totally

Thanks, this patch is much nicer.

greg k-h
