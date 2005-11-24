Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVKXCGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVKXCGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVKXCGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:06:55 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:24069 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1750959AbVKXCGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:06:54 -0500
Message-ID: <4385202E.70404@tuxrocks.com>
Date: Wed, 23 Nov 2005 19:06:38 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org
Subject: Mouse issues in -mm
References: <20051123033550.00d6a6e8.akpm@osdl.org>	<20051123175045.GA6760@stiffy.osknowledge.org> <20051123113854.07fca702.akpm@osdl.org>
In-Reply-To: <20051123113854.07fca702.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> Marc Koschewski <marc@osknowledge.org> wrote:
>>Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
>>persists,
> 
> You'l probably need to re-report the mouse problem if the previous report
> didn't get any action.

I'm not certain whether this is the same 'mouse problem', but I'll
report the mouse problems I've been seeing.  In the past several -mm
kernels, my touchpad has initially worked at boot, but 'tapping' has
stopped working at some point later (with no obvious kernel messages).

I've experienced this problem at least with 2.6.15-rc1-mm2 and
2.6.15-rc2-mm1, and reverting
input-attempt-to-re-synchronize-mouse-every-5-seconds.patch gives a
kernel without the touchpad problems.

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

iD8DBQFDhSAuaI0dwg4A47wRAvzYAJ94ifBDBTm7MfVsbTOZE8QG3NjZUwCggHv0
SQvehLxz6pLHs+5J+jTeaKU=
=Pkg2
-----END PGP SIGNATURE-----
