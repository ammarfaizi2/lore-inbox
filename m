Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318955AbSHSRWT>; Mon, 19 Aug 2002 13:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318954AbSHSRWT>; Mon, 19 Aug 2002 13:22:19 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51471 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318955AbSHSRWR>;
	Mon, 19 Aug 2002 13:22:17 -0400
Date: Mon, 19 Aug 2002 10:21:16 -0700
From: Greg KH <greg@kroah.com>
To: Jack Howarth <howarth@bromo.med.uc.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Linux 2.4.20pre3 breaks alsa 0.9.0.rc3
Message-ID: <20020819172115.GF23597@kroah.com>
References: <200208191609.MAA27419@bromo.msbb.uc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208191609.MAA27419@bromo.msbb.uc.edu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 22 Jul 2002 15:40:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 12:09:28PM -0400, Jack Howarth wrote:
>    I haven't seen this mentioned yet but the new
> pre3 changes remove the typedef of urb_t and purb_t
> from include/linux/usb.h. This causes alas-drivers
> 0.9.0rc3 to fail to compile. I wanted to find out
> if this removal of urb_t and purb_t was 
> final or if it would be regressed back in pre4?

Removal of those unneeded typedefs is final.

thanks,

greg k-h
