Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUGGW0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUGGW0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUGGW0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:26:53 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:37763 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265544AbUGGW0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:26:50 -0400
Message-ID: <40EC78A4.60304@sbcglobal.net>
Date: Wed, 07 Jul 2004 17:26:44 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6) Gecko/20040419
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: Re: 2.6.7-ck5
References: <40EC13C5.2000101@kolivas.org>
In-Reply-To: <40EC13C5.2000101@kolivas.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B949551580181C4C6366842"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B949551580181C4C6366842
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Con,

I'm running ck4 and I'm getting pauses during init (alsa, hdparm, 
hotplug).  By repeatedly pressing Alt-SysRq-p, I can get things going 
again within 15 seconds, otherwise I suspect it would take that 3 1/2 
hours to finish init like it did with ck3.  I think I had the same thing 
just happen in X.  The mouse got jerky and then stopped responding, even 
numlock wouldn't respond for about 15-30 seconds.  I'm logging a vmstat 
now to see if I can reproduce it.

It seems that disabling kernel preemption solved the problem during 
init, but the system feels slower (jerky mouse under X during compile).

Would anything that you've updated since ck4 take care of this?  If not, 
is there anything you can suggest I do to troubleshoot this issue?

Thanks,

Wes

Con Kolivas wrote:

> Patchset update:
>
> ...


--------------enig0B949551580181C4C6366842
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFA7HiqTH1dEI8IpaARAq+1AJ9xVXkkkpcexfgfeXQ2gigAIJlXJwCfS5y3
IzV6qeB+hlJ6aSB0OaDLZZM=
=tgrL
-----END PGP SIGNATURE-----

--------------enig0B949551580181C4C6366842--
