Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266358AbUFYNur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbUFYNur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266736AbUFYNur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:50:47 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:53704 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266358AbUFYNun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:50:43 -0400
Message-ID: <40DC2DAF.2090204@kolivas.org>
Date: Fri, 25 Jun 2004 23:50:39 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.7-ck2 (was Re: 2.6.7-ck1)
References: <40DC2D28.5020605@kolivas.org>
In-Reply-To: <40DC2D28.5020605@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Of course that should have been ck2 :P

Con Kolivas wrote:
| Updated patchset.
| These are patches designed to improve system responsiveness with
| specific emphasis on the desktop, but has scheduler changes
| suitable/configurable to any workload
|
| http://kernel.kolivas.org
|
|
| Summary of features:
| - staircase7.4 scheduler
|
| - batch scheduling
|
| - isochronous scheduling
|
| - autoregulated swappiness
|
| - autotuned vm page inactivation
|
| - supermount-ng
|
| - default cfq I/O scheduler
|
| - config hz
|
| - bootsplash v3.14
|
|
| Changed:
| - Updated staircase scheduler. Significant bugfixes and improvements
| have been made to the staircase scheduler since v7 that was in 2.6.7-ck1
| and updating is highly recommended. See separate announcement on lkml.
|
| Added:
| - autotuned vm page inactivation
| This extends the functionality of the autoregulated swappiness to now
| bias the active/inactive ratio according to the percentage of physical
| ram used by application pages. It has the effect of avoiding swap much
| more effectively, and drastically reducing the time spent in swap-thrash
| scenarios over and above the effectiveness of the autoregulated
| swappiness. The 2 are rolled into one sysctl which allows them to be
| disabled together (on by default) at /proc/sys/vm/autoregulate
|
| - default cfq i/o scheduler
| Self explanatory
|
| - config hz
| Self explanatory
|
| - bootsplash
| See www.bootsplash.org
|
|
|
| A full set of split-out patches are available with a series that can be
| used with the quilt application.
|
|
| The FAQ on my web page have also been updated.
|
| Comments, questions, suggestions welcome.
|
|
| Cheers,
| Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3C2vZUg7+tp6mRURAm7fAJ91/MGIGj8YGv/wBd6Fy1cCqTDuVACdHeXh
9tebXviDlKJsRU4aqzpLg6Y=
=/sXG
-----END PGP SIGNATURE-----
