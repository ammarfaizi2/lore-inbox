Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268921AbTCDAaK>; Mon, 3 Mar 2003 19:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbTCDAaK>; Mon, 3 Mar 2003 19:30:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55313 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268921AbTCDAaI>;
	Mon, 3 Mar 2003 19:30:08 -0500
Date: Mon, 3 Mar 2003 16:31:20 -0800
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
Message-ID: <20030304003120.GB19721@kroah.com>
References: <20030303182553.GG16741@kroah.com> <20BF5713E14D5B48AA289F72BD372D6803945AB6-100000@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D6803945AB6-100000@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 02:56:23PM -0600, Matt Domsch wrote:
> > > 2) Add new IDs at runtime and have the drivers probe for the new IDs.
> > 
> > Ick, no.  If a driver really wants to have a user provide new ids on the
> > fly, they usually provide a module paramater to do this.
> 
> Yes, I've done this kind of thing too with aacraid.  I was hoping to 
> generalize the process and build upon the ID table already present.

Ok, you and Alan have convinced me :)

I'd like to see what your patch looks like to add this kind of support.

thanks,

greg k-h
