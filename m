Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSLCOcV>; Tue, 3 Dec 2002 09:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSLCOcU>; Tue, 3 Dec 2002 09:32:20 -0500
Received: from adsl-b3-72-99.telepac.pt ([213.13.72.99]:37522 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id <S261495AbSLCOcT>; Tue, 3 Dec 2002 09:32:19 -0500
Message-ID: <3DECC289.2050500@vgertech.com>
Date: Tue, 03 Dec 2002 14:41:13 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: nelsonis@earthlink.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Quad ethernet card getting assigned different channels every
 install
References: <3DECBCA7.2010502@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can load the module and specify the I/O address of each mii. This 
way you'll allways get the same eth for a given I/O. Read the module's 
fine manual :)

Regards,
Nuno Silva

Ian S. Nelson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> The kernel is 2.4.18, from Redhat. I've looked at some of the code and I 
> think this might actually be a hardware bug.  I'm helping setup a 3 port 
> firewall, I'm remote so I haven't been hands on,  the guy has a quad 
> ethernet card in it.  Between kernel installs eth0, eth1, eth2, and eth3 
> seem to change which socket on the card they are.
> 
> Anyone seen anything like this before?  The hardware didn't change and 
> to my knowledge no BIOS changes have happened.  I'd assume that the PCI 
> bus would be enumerated the same each time and that the kernel, barring 
> changes to PCI device discovery, would give the same ethernet channel to 
> the same socket each time.  It boots consistently when we figure out 
> what port is what.
> 
> In this particular case it's potentially a big security concern, if we 
> swapped the DMZ and protected zones and didn't notice then his network 
> might be exposed.
> 
> 
> thanks,
> Ian
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.0 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQE97LykV28blwDT2YMRAribAJ9N/kevyPK2ALbZqplzRnW2pp/mEACfe/cN
> ug4c/2WZtGH7g5MzPBkU0xs=
> =wykB
> -----END PGP SIGNATURE-----
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


