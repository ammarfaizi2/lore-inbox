Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUHGWCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUHGWCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUHGWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:02:00 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:60318 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264499AbUHGWBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:01:37 -0400
Message-ID: <41155138.4090707@sbcglobal.net>
Date: Sat, 07 Aug 2004 17:01:28 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.7) Gecko/20040720
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Michael Guterl <mguterl@gmail.com>, linux-usb-devel@lists.sourceforge.net,
       Luis Miguel Garc Mancebo <ktech@wanadoo.es>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
References: <200408022100.54850.ktech@wanadoo.es> <200408050834.27452.david-b@pacbell.net> <944a03770408051005614aa25e@mail.gmail.com> <200408071051.23047.david-b@pacbell.net>
In-Reply-To: <200408071051.23047.david-b@pacbell.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC1F9197DABD1006A64B9C0FF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1F9197DABD1006A64B9C0FF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



David Brownell wrote:

>On Thursday 05 August 2004 10:05, Michael Guterl wrote:
>  
>
>>Thanks for the reply David, but where exactly does this leave me and
>>the others experiencing this problem?  Is there any more information I
>>can provide that might help?  Any possible solutions, patches, etc?
>>    
>>
>
>It leaves you (and others) with the problem partially isolated, so that
>someone with time to track it down will have that much less work to do.
>[...]
>A third-best would be for someone (you?) to find out exactly which patch
>caused the problem -- a binary search of the USB patches, luckily it's
>made easier by the fact that it could only be a change in HID, usbcore,
>or some HCD.  (And most likely IMO it's usbcore.)  Then that patch can
>either be further debugged, or reverted.
>
>- Dave
>
>  
>
OK, I'm willing since I'm stuck with 2.6.7-ck5 which eventually bugs due 
to some USB problems.  I'm not a developer so I need a little help 
learning how to get the USB patches added somewhere in between 2.6.7 and 
2.6.7-mm2/2.6.8-rc1.  I'm kinda busy right now so maybe I didn't search 
the kernel.org website well enough, but I've reached the conclusion I'll 
need to use bk or the cvs interface.  So if someone can give me a quick 
and dirty tutorial or point me to where I can read up on this (or just 
give me some google search terms) I'd be willing to apply patches until 
it breaks and try to figure out what's going wrong.

Thanks,

Wes

--------------enigC1F9197DABD1006A64B9C0FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBFVE8TH1dEI8IpaARAk3EAJ4gkjx5Y4cWRwqnviFpH1HZRT9kMACghKKV
ILB8ZxbTWkeYOGmWt+upTtw=
=Q12u
-----END PGP SIGNATURE-----

--------------enigC1F9197DABD1006A64B9C0FF--
