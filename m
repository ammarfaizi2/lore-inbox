Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSHFQdt>; Tue, 6 Aug 2002 12:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSHFQds>; Tue, 6 Aug 2002 12:33:48 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:10257 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313419AbSHFQdr>;
	Tue, 6 Aug 2002 12:33:47 -0400
Date: Tue, 6 Aug 2002 09:34:47 -0700
From: Greg KH <greg@kroah.com>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Policy vs API (was Re: [PATCH] integrate driverfs and devfs (2.5.28))
Message-ID: <20020806163447.GA698@kroah.com>
References: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net> <200208051225.g75CP4v316564@pimout4-ext.prodigy.net> <20020805231914.GF29396@kroah.com> <20020806055922.26D48644@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020806055922.26D48644@merlin.webofficenow.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 09 Jul 2002 15:14:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 07:51:21PM -0400, Rob Landley wrote:
> 
> I'm under the vague impression that devicefs may somehow become the new 
> driver API at some point after Buck Rogers returns from his frozen orbit.  

Sorry, but it is the new driver API right now :)
PCI is pretty much already done in the latest 2.5 kernel, and I'm trying
to finish up the USB conversion within the next few days.

Also, to address all of the other comments that I snipped out of your
email, please go read the documentation and paper at:
	http://www.kernel.org/pub/linux/kernel/people/mochel/doc/
to get an idea of what is happening, and what it looks like.

You can also mount driverfs right now to see what it looks like for your
system.

If you have any further questions or comments after reading the above
documentation, and playing around with the existing driverfs filesystem,
please let us know.

thanks,

greg k-h
