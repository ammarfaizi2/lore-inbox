Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSFAANG>; Fri, 31 May 2002 20:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSFAANF>; Fri, 31 May 2002 20:13:05 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:14602 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316965AbSFAANE>;
	Fri, 31 May 2002 20:13:04 -0400
Date: Fri, 31 May 2002 17:11:14 -0700
From: Greg KH <greg@kroah.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>, David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.19 -- 2 OOPSen during boot process.
Message-ID: <20020601001114.GA3573@kroah.com>
In-Reply-To: <3CF80D0B.4070600@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 03 May 2002 23:04:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 04:53:47PM -0700, Miles Lane wrote:
> 
> >>EIP; d98f1234 <[ohci-hcd].data.end+1cd95/26b61>   <=====
> Trace; c0190d0a <pci_unregister_driver+2a/70>

This isn't a usb problem, it's caused by the pci changes that are in
2.5.19.  I can get an oops by removing any pci driver from my system.

thanks,

greg k-h
