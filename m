Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbTCGWNO>; Fri, 7 Mar 2003 17:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTCGWNK>; Fri, 7 Mar 2003 17:13:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13068 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261828AbTCGWNH>;
	Fri, 7 Mar 2003 17:13:07 -0500
Date: Fri, 7 Mar 2003 14:13:43 -0800
From: Greg KH <greg@kroah.com>
To: Ed Wildgoose <Ed@Wildgooses.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt problem, no USB on SMP machine with 2.4.19/20/21
Message-ID: <20030307221343.GC21315@kroah.com>
References: <3E68F616.3090602@Wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E68F616.3090602@Wildgooses.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 07:42:14PM +0000, Ed Wildgoose wrote:
> I am running a dual intel P3 933Mhz machine with an EPOX EP-D3VA 
> motherboard.  This has a via VT82C693A/694x [Apollo PRO133x] chipset
> 
> I cannot seem to get USB working at all on this machine.  I have tried 
> 2.4.19 20 and 21-ac (latest as of yesterday) with no luck.  Basically 
> doing insmod usb-uhci generates errors in the log:

Have you booted with "noapic" on the command line?  That's the only way
a lot of VIA motherboards will get their onboard USB controller to work
properly.

thanks,

greg k-h
