Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbULHU4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbULHU4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbULHU4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:56:32 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:36336 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S261356AbULHU42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:56:28 -0500
Message-ID: <41B769C4.9040104@inostor.com>
Date: Wed, 08 Dec 2004 12:53:24 -0800
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic removing psnap or p8022 module in 2.4.28  (appletalk
 dependencies)
References: <41B75BBF.8070004@inostor.com> <41B76130.8030607@inostor.com>
In-Reply-To: <41B76130.8030607@inostor.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030406090003040604020503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030406090003040604020503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is the ksymoops. The first one (ksymoops.txt) is the ksymoops run without the
modules loaded.

The second one (ksymoops2.txt) is with appletalk.o psnap.o and p8022.o loaded.
Only one line is different:

gentoogato root # diff ksymoops.txt ksymoops2.txt
34c34
< >>ebx; cc84a3c0 <.data.end+1b41/????>
- ---
| >>ebx; cc84a3c0 <[p8022]p8022_packet_type+0/0>

I hope this is helpful. Let me know if there is anything more I can run.

Tom Dickson wrote:
| Next time I promise to finish the report before hitting send.

SNIP

| Thank you!
|
| -Tom Dickson
|
| Tom Dickson wrote:
| | I've attached the config file used to compile the vanilla 2.4.28 kernel
| | that produces the following panic:
| |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFBt2nD2dxAfYNwANIRAtpzAJ9HNC0iCJoDs4iNNueDPgyIIOyj0QCYppIj
hQIAFgjqVePU65hBPEAlqg==
=Ci8h
-----END PGP SIGNATURE-----

--------------030406090003040604020503
Content-Type: application/x-gzip;
 name="ksymoops.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ksymoops.gz"

H4sIAIlpt0EAA+1YW2/bNhTOs37F2UOxFE4sUjfLieuhKLoh2LB27bphKAKDIqlYi26TqMT5
9zukLr7Ea9eHdtim82DxkIfn+pEmeVs/ZEVR1lO1USefiQhS4Hnmi3T4DQj1Tiihvh+glINy
1PV8egLkczm0S02tWAVwUhXFBxPwsfHD4P4ldNvVH5ypN51DkUMShIHhnHAK8KpUSZHX0NRS
WKDp/Bc4FTJmTaqedj23YJdVwW2trH40mnajWSGaVD4eL8BOk6gftlvT9iOxDOymruy64iie
Nxv77UOtZDbNWLkja/3KqjzJby7gt6IBkQjICwVKpilkEu7XspKgCoiTXAB6GxUpJHlcVBnT
cWLAV3CfpKnF6rrBCWrNcPZaQlrcAMrwNQag+VtZ5TIFhmr6uIwsQ/1Vk2sXrCq5WSu0f2/E
rr5GHzCNZnrnLxRdellU3ElAP3qnKlkXaWN8sq5iM4c3VSVztWPaRvneuihMpMbH3uMzeMAk
cJbDjVRWVqBvjKMapiQUjSobBdGDSQ66C5ncjexOVjVaN67vpc3ChJ/1Zs+grblUHHM3gOl8
DXJTpizJ22x1YU4t6xUOX4BeIdaL1+8udGWJ9fLqddsilFy8X3DiuKE3J8tr3fmjrh9qUgjA
d7V2tEteDXFVZDtGFcg0dp3zxEUEnzPQX+vltz88/+6tMUmJgx2SbVoHkDzULyPkOQ895nKi
eY68R6OZz71Q80KPUzdwIye0ZJ0gFwUi8KWRFkmnzSOGj8rWlhv5geZr5DlxSRTT0BImdmrU
bpt117Re4zKRdQ31PStLWcFpmQgcmgLuUfy2ZDfymVGF+p9ab3Vfr5sR44T0CDWxUB4LdJNH
kXari7ZveARMigPHHUJpFxlodY4nAt42OAu3wXSTg3byzPW2Mq0TvtfKUIf36jrDtBWNZgTi
liLsoZTPZv52yDTmbPDX12n3JA8QKwwXz88V49IABTHSBYkY6QCD0WwZ9K5jWiM9Q5gfs+W1
BR0bxC4Zxvh8Fg7M3kgQ++4OI52B8dFP1PeiEOhZEIA7BzeCmQcBgTACPwKKDR8EdvoQe6bt
aAE30AIzBoRjp2VZyyWug0vo0Q+LXKokXlWSy+ROrurbaDInNmVkiRlYPNOkJyF+L7f4XUwF
U2wqczGhkUftb5CWWkpoqQ7FsFgZAQSMH3Gbe3LOYs+I1cnlFt6tWOSGlMy8fbHyckA1LJI8
USvF6ttVk+M6n1DstR2dGcsyRbvcgnLx3uX+fHMdFUUmK5bfrPTSrqqmVJNI2K7ASf2cHqSL
sl0Yqwghj/vaJHRt6hwIakDqlK2qzYpxvd9M0GlKd8U6xC1EsaqLWCXVH5O5b7M9EQMRI3L1
5qfJnB0Oa2DgcLsHrRKRygmxvX0ZjSRYcATtqtPj2+KTtWjUHcg47mMh6aCpsmkFfMee7Qto
hGIl8b9yo9CGrolG6yX8HaRZw9axWCE6lxefMHeLUr0R6HU7rI9HxLNSf56I5Oz0CSL66Xby
vkH3qEG3dRYnudpOu/yO0e/SfAK/jWdCNoG/PDDhHzXhDyZ8bWJY248oK+7MzrehpA3lTP8e
2AiP2ggHG6GxYbaNY6RkrXS6UPEx7eyodjZoZyZJZjs6mqTcZKmv+YFyflQ5H5Tz3nXnw64L
7bo4dF0e1S4H7bKrrxt8qL74J9XX1wsOAmBHMctIb4KSrr7t1vzX9eWn2n9dXpEcmDiKUjag
lLpdjshxlA45Yhu9HNgGz7WwIMvv26NZyfIEs/w8kRLPX0l7eht2UVjjkU1WX1kWhfv2MAwJ
nmalwBPaG1mbk1PGHsxxMcLTqkwTFqVyav3Td5GRvjz1p2fnMz4AfPT+7/iH93/f9cf7/5eg
8f4/3v/H+/94/x/v//+R+//7MiSOc21+VyVCBG/E6qGU7dVvfAgYHwLGhwAYHwLGh4DxIWB8
CBhppJFGGmmkkUb6/9GfPSXmawAoAAA=
--------------030406090003040604020503--
