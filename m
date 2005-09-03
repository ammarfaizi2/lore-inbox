Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbVICJXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbVICJXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 05:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVICJXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 05:23:10 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:34448 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750824AbVICJXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 05:23:09 -0400
Message-ID: <43196B55.1040904@fulhack.info>
Date: Sat, 03 Sep 2005 11:22:29 +0200
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dominik Brodowski <linux@brodo.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.13
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org> <4314E07F.2080807@fulhack.info> <20050901022938.GA27209@kroah.com>
In-Reply-To: <20050901022938.GA27209@kroah.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD5E26EA543F21D8FB9765CB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD5E26EA543F21D8FB9765CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Wed, Aug 31, 2005 at 12:41:03AM +0200, Henrik Persson wrote:
> 
>>Linus Torvalds wrote:
>>
>>>There it is. 
>>>
>>>The most painful part of 2.6.13 is likely to be the fact that we made x86
>>>use the generic PCI bus setup code for assigning unassigned resources.  
>>>That uncovered rather a lot of nasty small details, but should also mean
>>>that a lot of laptops in particular should be able to discover PCI devices
>>>behind bridges that the BIOS hasn't set up.
>>>
>>>We've hopefully fixed up all the problems that the longish -rc series
>>>showed, and it shouldn't be that painful, but if you have device problems,
>>>please make a report that at a minimum contains the unified diff of the
>>>output of "lspci -vvx" running on 2.6.12 vs 2.6.13. That might give us
>>>some clues.
>>
>>Well. 2.6.13 won't boot if I have my Netgear WG511 in the cardbus slot.
>>It boots just fine if it isn't inserted, though. If I insert it later
>>on, the computer will freeze and won't respond, just like it does on boot.
>>
>>2.6.12.5 works just fine, and I just did make oldconfig and used the
>>defaults (except for the hardware monitoring).
>>
>>Suggestions, anyone?
> 
> 
> Can you try the patch posted to lkml at:
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=112541348008047&w=2
> from Ivan to see if that helps this?

Indeed. 2.6.13 now booting without any problems at all (well, no
problems yet anyway..) :)

--
Henrik Persson

--------------enigCD5E26EA543F21D8FB9765CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDGWtbp5uk1YPOcmcRAmWMAJ0d4moYcvlelUPzUxjvVpzyp8NmvwCgnIoD
j2b92DKgyYNZ4U2S23aTxeU=
=1r+R
-----END PGP SIGNATURE-----

--------------enigCD5E26EA543F21D8FB9765CB--
