Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317715AbSGPAYL>; Mon, 15 Jul 2002 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317716AbSGPAYK>; Mon, 15 Jul 2002 20:24:10 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:21519 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317715AbSGPAYI>;
	Mon, 15 Jul 2002 20:24:08 -0400
Date: Mon, 15 Jul 2002 17:26:13 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: benh@kernel.crashing.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
Message-ID: <20020716002613.GB32431@kroah.com>
References: <20020713.135235.83621938.davem@redhat.com> <20020713134553.4483@192.168.4.1> <20020714.222527.57270686.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714.222527.57270686.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 17 Jun 2002 23:22:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:25:27PM -0700, David S. Miller wrote:
>    From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>    Date: Sat, 13 Jul 2002 15:45:53 +0200
>    
>    That case shouldn't be a problem, since when your device get discovered,
>    hopefully, the host controller is already there. Though in some cases,
>    host controllers just appear as a sibling device, and in this specific
>    case, it may be not have been "discovered" yet.
> 
> THat's not what I'm concerned about, what I care about is that there
> still will be a pci_find_*() I can call to see if DEV/ID is on
> the bus.  That is the easiest way to perform that search right
> now.

Yes, it will stay.  It is needed for situations just like these, and lots
of other valid reasons.

thanks,

greg k-h
