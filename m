Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSHBW0Y>; Fri, 2 Aug 2002 18:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSHBW0Y>; Fri, 2 Aug 2002 18:26:24 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:41996 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316709AbSHBW0Y>;
	Fri, 2 Aug 2002 18:26:24 -0400
Date: Fri, 2 Aug 2002 15:27:58 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 breaks cciss driver?
Message-ID: <20020802222758.GA1687@kroah.com>
References: <20020802154751.A1943@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020802154751.A1943@zuul.cca.cpqcorp.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 05 Jul 2002 21:12:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 03:47:51PM -0500, Stephen Cameron wrote:
> 
> I just saw this problem with 2.5.30.
> 
> I can't mount my 2nd volume on a cciss controller (SmartArray 5i)
> 
> < /dev/cciss/c0d1p1 /u1
> No such device or address
> 
> The first volume, /dev/cciss/c0d0p1, works fine
> (I'm booted from it.)
> 
> Reboot 2.5.29, both volumes work fine.
> 
> I don't have time to look into this right now,
> but I thought I'd mention it in case someone else
> does have time.  Looks like there was some partition 
> code and/or devfs changes...

Are you running in "devfs=only" mode?  If so, the changes I made
probably are the cause of this.

thanks,

greg k-h
