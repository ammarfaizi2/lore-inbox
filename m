Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSB0Ayv>; Tue, 26 Feb 2002 19:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSB0Aym>; Tue, 26 Feb 2002 19:54:42 -0500
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:11016 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S290818AbSB0Ay2>; Tue, 26 Feb 2002 19:54:28 -0500
From: System Operator <root@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200202270049.g1R0nwE14181@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: please remove CONFIG_PNP, CONFIG_PNPBIOS
In-Reply-To: <1014770275.6708.244.camel@thanatos> from Thomas Hood at "Feb 26, 2 07:37:53 pm"
To: jdthood@mail.com (Thomas Hood)
Date: Wed, 27 Feb 2002 01:49:58 +0100 (MET)
Cc: herp@wildsau.idv-edu.uni-linz.ac.at (Herbert Rosmanith), wastl@liwest.at,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > by checking 2.4.18, I saw that "CONFIG_PNP" is not in use in the
> > source anymore except in Documentation/Configure.help and as a
> > variable that CONFIG_ISAPNP depends on.
> >
> > => remove.
> 
> Hold on.  This will change once the pnpbios driver
> is merged.  It's currently in Alan's tree (and in 2.5 stock).


hm. this only adds to confusion.


> > as a side note, I'd want to know how linux is configuring 
> > the PCI devices, when e.g. in the Bios Settings I say 
> > "Yes - PNP aware OS installed". 
> 
> When you enable "PnP OS" in the BIOS, you are telling 
> the BIOS not to use PnP methods to configure PnP devices, 
> but to leave it to the OS to do the configuration. 

and Linux is such an OS?
 
> > can also someone tell me which variable the "CONFIG_PNPBIOS" options 
> > depends on? this seems to be another variable which is only 
> > "used" on Documentation/Configure.help. 
> 
> pnpbios is a driver used to communicate with the 
> PnP BIOS.  This driver should be merged soon, but right 
> now only the help text for the driver is present in stock 2.4. 
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 

> In the case of ISA devices, Linux only configures them 
> if you have the isa-pnp driver built. 

And If I have ISA-devices, which I have not.
 
> Actually, I don't see why we should ever set the "PnP OS" 
> flag.  It doesn't hurt to let the BIOS preconfigure 
> devices.  Linux can always re-configure devices as it 
> sees fit, can't it? 

As it seems, Linux cannot reconfigure devices, since only the
helptext for the driver is present, while a driver is
not present. At last not in 2.4. Only a dummy option
with a dummy help text *without even a note* that this is
not implemented!


 
