Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSLCOIj>; Tue, 3 Dec 2002 09:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSLCOIj>; Tue, 3 Dec 2002 09:08:39 -0500
Received: from mail-1.ricochet.nethere.net ([66.63.158.19]:16655 "EHLO
	mail-1.ricochet.nethere.net") by vger.kernel.org with ESMTP
	id <S261456AbSLCOIh>; Tue, 3 Dec 2002 09:08:37 -0500
Message-ID: <3DECBCA7.2010502@earthlink.net>
Date: Tue, 03 Dec 2002 07:16:07 -0700
From: "Ian S. Nelson" <nelsonis@earthlink.net>
Reply-To: nelsonis@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Quad ethernet card getting assigned different channels every install
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


The kernel is 2.4.18, from Redhat. I've looked at some of the code and I 
think this might actually be a hardware bug.  I'm helping setup a 3 port 
firewall, I'm remote so I haven't been hands on,  the guy has a quad 
ethernet card in it.  Between kernel installs eth0, eth1, eth2, and eth3 
seem to change which socket on the card they are.

Anyone seen anything like this before?  The hardware didn't change and 
to my knowledge no BIOS changes have happened.  I'd assume that the PCI 
bus would be enumerated the same each time and that the kernel, barring 
changes to PCI device discovery, would give the same ethernet channel to 
the same socket each time.  It boots consistently when we figure out 
what port is what.

In this particular case it's potentially a big security concern, if we 
swapped the DMZ and protected zones and didn't notice then his network 
might be exposed.


thanks,
Ian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE97LykV28blwDT2YMRAribAJ9N/kevyPK2ALbZqplzRnW2pp/mEACfe/cN
ug4c/2WZtGH7g5MzPBkU0xs=
=wykB
-----END PGP SIGNATURE-----


