Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUKSJw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUKSJw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUKSJw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:52:29 -0500
Received: from main.gmane.org ([80.91.229.2]:12961 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261222AbUKSJwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:52:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: [2.6.10-rc2] In-kernel swsusp broken
Date: Fri, 19 Nov 2004 01:52:12 -0800
Message-ID: <419DC24C.9000902@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-237-170.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041116)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

It seems that as of 2.6.10-rc2 my laptop no longer is able to suspend to
disk with an echo disk > /sys/power/state. It goes to freeing memory,
and then blanks the screen. Usually, the screen will turn on again, it
will write data to the swap partition then power off by itself, but
instead, the screen stays off, the CPU starts going wild, and a hard
reset is necessary. It used to work in 2.6.10-rc1.

Is there any help I can provide with this? It looks like I will have to
binary search between rc1 and rc2, but I won't have time for that until
next week...

Thanks

- --
Joshua Kwan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQZ3CTKOILr94RG8mAQJLORAApFCdXmypSd01waNJIoL+p+mkqVo3CR7N
Y/234lWewXAOODjdpAPafjD3LFa9ycQCcxuGXB9dkYI2OHVCHxREGdyRVeFiPb5j
jN5hJp8JtDfLeionmdQr3yBSks+u4EjWpF4qWW75eK8pzPDoDsOp8xc3qhMvLFly
mXLcGq2irLiLJ3blXCEmA1iM7RKFSsk60stMuCLJd/lbncIkeocu+HWUKz0P0Va1
9EEnfhcMNLTqj8idUcnQItEFDZFGagEIdGv4/8ISSTMfLhihObs35i6t1ub/Ay8e
1SzU2Ne7EzkDrV8Na2bm5AtVhh5thS3ekdn+n76k+hnlIHifa3lLG6a/EycDOYCP
e0NGGqi0fy1QlVaX/ro+OQOsWIvfqwQusI5kNxBWnvdgx9kIO4HW4vm1elJaKaGp
xDnJOAmFIKbrNmdTlxU6trbwRZ1nBHhPf58Nfkj97XS2kTBRhjXxeOmj288pVO87
teEwZAQFzovq0gW9T95pRSiiT+9guvRlGBTwpFPEZ940oVun9R+aqZpaxpRMC6Cn
bgzoUpPe/OOtWQqYcaL5hbXXvAZ+8M10LXp7+GLYjKKQ1/QcSDdjbfDCEqb2ugGk
iAQRLqd/Z85UP133xQeq9XYmk/qovsEOPppFuX48RQvb+wSC3yQUJ098nXRUKXjE
ygG4nhUhrg0=
=peP5
-----END PGP SIGNATURE-----

