Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWCQRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWCQRSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWCQRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:18:05 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:60870 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932748AbWCQRSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:18:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:openpgp:content-type;
        b=mPjnkU6Vrtu4UvDJMzEZ7gA23ONS7x4grisXpJIV6YmGpSCzti0KelhwNxFBctfjIMbj9SkkLsS6DAvYB1fOel8EsgDuYEJW8x7j8se2cvZjUGwq/040RbHK6Mm8hjKLJJRA1T1BfyDmpK9q6qHJ/UQph4OH8SNhFRuk0xO2Z5g=
Message-ID: <441AEF45.6080200@gmail.com>
Date: Fri, 17 Mar 2006 19:17:57 +0200
From: Georgi Alexandrov <georgi.alexandrov@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: removing iptable_nat module problem.
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=37B4B3EE;
	url=http://pgp.mit.edu/
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBEE91D9283A260274917A91F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBEE91D9283A260274917A91F
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit

Hello,

I've tried to modprobe -r iptable_nat on a debian testing system running
debian's 2.6.15-1-686 kernel. Now modprobe is taking 99% cpu resources
and can't be killed even with -9. I've tried to kill it's parents (ssh
---- bash --- modprobe) but that didn't help too.
I don't want to restart the machine as it is a production one and alot
of people count on it.
Exactly the same thing happened when the machine was in the "testlab"
(pre deployment) and i tried to rmmod ip_conntrack.

Is that some kind of kernel issue? Can i stop that process someway?

thanks in advance


-- 
regards,
Georgi Alexandrov

Key Server = http://pgp.mit.edu/ :: KeyID = 37B4B3EE
Key Fingerprint = E429 BF93 FA67 44E9 B7D4  F89E F990 01C1 37B4 B3EE


--------------enigBEE91D9283A260274917A91F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEGu9F+ZABwTe0s+4RAjJJAJ4qoagDID+Vt377FFXjIaon4IEdigCeNkq1
mX+x0ImCoyQhI4CYkqBEWd8=
=K1+/
-----END PGP SIGNATURE-----

--------------enigBEE91D9283A260274917A91F--
