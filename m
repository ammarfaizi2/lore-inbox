Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbTCCSsb>; Mon, 3 Mar 2003 13:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268715AbTCCSsb>; Mon, 3 Mar 2003 13:48:31 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31388
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268714AbTCCSs3>; Mon, 3 Mar 2003 13:48:29 -0500
Subject: Re: Displaying/modifying PCI device id tables via sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mochel@osdl.org
In-Reply-To: <20030303182553.GG16741@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D680392F82C-100000@AUSXMPC122.aus.amer.dell.com>
	 <20030303182553.GG16741@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046721774.7314.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 20:02:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 18:25, Greg KH wrote:
> > 2) Add new IDs at runtime and have the drivers probe for the new IDs.
> 
> Ick, no.  If a driver really wants to have a user provide new ids on the
> fly, they usually provide a module paramater to do this.  A number of
> the USB drivers do this already (and to be honest, they have caused
> nothing but trouble, as users use that option for new devices, that the
> driver can't control at all due to protocol or register location
> changes.)
> 
> In short, it's not a good idea to allow users to change these values on
> the fly, the driver author usually knows best here :)

I would strongly disagree with that statement. The majority of users run
kernels a little behind the times, and in may cases adding the PCI id is
just fine. It doens't want to be casual and uncontrolled but it does want
to be possible

