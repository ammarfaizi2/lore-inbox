Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbUDNMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbUDNMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:37:25 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:14854 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S264139AbUDNMhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:37:14 -0400
In-Reply-To: <20040414090547.GB13578@raptus.homelinux.org>
References: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net> <20040414090547.GB13578@raptus.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-41-559794883"
Message-Id: <6699459A-8E10-11D8-A41D-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: reiserfs-list@namesys.com,
       Linux mailing list SCSI <linux-scsi@vger.kernel.org>,
       Atul Mukker <atulm@lsil.com>, Hans Reiser <reiser@namesys.com>,
       Linux mailing list kernel <linux-kernel@vger.kernel.org>
From: Paul Wagland <paul@wagland.net>
Subject: Re: reiser4 and megaraid problems with debian 2.6.5
Date: Wed, 14 Apr 2004 14:36:49 +0200
To: Domenico Andreoli <cavok@libero.it>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-41-559794883
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 14, 2004, at 11:05, Domenico Andreoli wrote:

> [ bringing this also on reiserfs ml, a great place for this kind
>   of posts.  this is also the reason of the full quoting. sorry ]

Thanks ;-)

>> I am using the debian prepared kernel with the debian reiser4 patch. I
>> made a cursory examination of the patch, and it appears to correlate
>> fairly closely with the patch from the namesys site.
>
> you forgot to specify version of the patch you are talking about,
> currently debian provides two versions. anyway i suppose you are 
> talking
> about version 20040326-2, aren't you?

Yes, that is correct.

>> If I can help debug this situation (I am probably the only person
>> trying this combination :-) please let me know how I should go about
>> it.
>
> i'm sorry but i can't help further.

Thanks for the tip... the link that you referred to was most useful. I 
might now have an idea what the problem might be... Further on in the 
thread <http://marc.theaimsgroup.com/?l=reiserfs&m=108117079808733&w=2> 
it says that there is something in the patch that "can lead to a 
dirtied_when in the future, and missed writeback". Well, what happens 
if the directory that I am missing was in that writeback that got 
missed?

I will try updating the debian patch myself and give it another test 
tonight and will report back on my findings. But, before I do so, does 
it seem likely that this could cause the problem?

Cheers,
Paul

--Apple-Mail-41-559794883
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAfTBltch0EvEFvxURAue8AKCwkI2vPJFS0kIUIaihIKIig5GPDgCbBd+t
QQr6QenCEvMrr0ZKBSOpgHk=
=N/Vu
-----END PGP SIGNATURE-----

--Apple-Mail-41-559794883--

