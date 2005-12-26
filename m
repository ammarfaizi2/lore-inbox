Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVLZEk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVLZEk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVLZEk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:40:27 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:45326 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751004AbVLZEk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:40:27 -0500
Message-ID: <43AF742E.5040604@tuxrocks.com>
Date: Sun, 25 Dec 2005 21:40:14 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
References: <43ACEE14.7060507@feise.com> <20051224104224.GA5789@stiffy.osknowledge.org> <43AD29A6.10407@tuxrocks.com> <200512252309.07162.dtor_core@ameritech.net>
In-Reply-To: <200512252309.07162.dtor_core@ameritech.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> On Saturday 24 December 2005 05:57, Frank Sorenson wrote:
> 
>>I continue to see the same issues with the resync patch in -mm.  For me,
>>tapping stops working, and I'm now seeing both the mouse pointer jumping
>> as well (a lesser issue for me, so it was probably present earlier as
>>well).
>>
> 
> Frank,
> 
> Does the tapping not work period or it only does not work first time you
> try to tap after not touching the pad for more than 5 seconds?

The tapping works initially, then stops.  I hadn't put 2+2 together with
the 5-second idle bit, but that seems the likely issue.

I applied that patch you sent out yesterday, and now tapping works and
I'm not seeing the mouse stall/jump problem.  I'm at 21+ hours uptime
now, with no mouse problems, so I think setting the resync_time to 0
looks like the right fix.

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDr3QuaI0dwg4A47wRApTrAKCznvvBq5lX66VPggjP6KTtbFQdDgCgmrhs
x+90pceDtoWznfjy6kBGaAs=
=e2Xa
-----END PGP SIGNATURE-----
