Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277833AbRJIQzE>; Tue, 9 Oct 2001 12:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277832AbRJIQyC>; Tue, 9 Oct 2001 12:54:02 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:6406 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S277836AbRJIQxg>;
	Tue, 9 Oct 2001 12:53:36 -0400
Message-ID: <3BC32AAD.927DDF5E@osdlab.org>
Date: Tue, 09 Oct 2001 09:49:49 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "SATHISH.J" <sathish.j@tatainfotech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane List <stephane.list@fr.alcove.com>
Subject: Re: Reg-network driver.
In-Reply-To: <Pine.LNX.4.10.10110091750390.11843-100000@blrmail>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maybe you didn't tell cscope to search in linux/net/core/* .
It's there, in dev.c .

~Randy

"SATHISH.J" wrote:
> 
> Hi stephane,
> 
>  I have cscope installed to search source files.
> I could not find "register_netdevice()" functionthrough it. I want to see
> where it calls the driver initialisation.
> Please help me out.
> 
> Thanks in advance,
> Warm regards,
> sathish.j
> On Tue, 9 Oct 2001, Stephane List wrote:
> 
> > On Tue, Oct 09, 2001 at 02:35:37PM +0530, SATHISH.J wrote :
> > > Hi all,
> > > I am trying to learn network drivers. Trying to initialise the driver we
> > > call "register_netdev()". This function in turn calls
> > > "register_netdevice()". Please tell me where register_netdevice() is
> > > defined. I want to see the code because the init function of the driver is
> > > called from function only as I heard. Please tell me where
> > > "register_netdevice()" and "unregister_netdevice()" are defined in the
> > > code.
> > >
> > You can see it with :
> >
> > http://lxr.linux.no/ident?i=register_netdevice
> >
> > You can also install LXR on your own PC.
