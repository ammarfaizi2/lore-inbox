Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWJNVoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWJNVoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWJNVoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 17:44:04 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:22708 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964796AbWJNVoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 17:44:03 -0400
Message-ID: <45315A20.6090600@comcast.net>
Date: Sat, 14 Oct 2006 17:44:00 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Kevin K <k_krieser@sbcglobal.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers?
References: <4530570B.7030500@comcast.net> <20061014075625.GA30596@stusta.de> <4530FC8E.7020504@comcast.net> <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>
In-Reply-To: <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Kevin K wrote:
> 
> On Oct 14, 2006, at 10:04 AM, John Richard Moser wrote:
>> My math predicts that 2.6.57 (+39) will be 100M (in approximately 7
>> years if you assume 1 kernel release every 2 months); 2.6.92 (+35) will
>> breech 200M; 2.6.117 (+25) will breech 300M; and 2.6.138 (+21)) will
>> breech 400M.  That should suffice for predictions over the next 20 years
>> based on this crude model.
>>
> 
> Who knows.  By that time, CPU caches may be that size.  And hopefully
> tools are developed to an extent that they can automate cleanup.
> 

Yeah, a static code coverage analyzer or some sort of code-reducer would
be nice; these are in general pipe dreams but eh.  Also these are
compressed bzip2 tarball sizes, not compiled kernel sizes or source tree
sizes.  I would imagine a 100MB bzip2 would turn into something quite
large; the major issue is the amount of work it takes to maintain
something like that.

I am slowly forming the prediction that monolithic kernels won't survive
(Net/Open/FreeBSD, Linux) and only microkernels or so-called
"nanokernels" (or the exokernel ...) will be maintainable EVENTUALLY;
however I don't have sufficient data, as one would have to illustrate a
maintenance advantage in those models to complete that prediction and I
lack understanding to do such.  Besides, there's no good data on the
upper bound of what is maintainable; it's somewhere below the size of
the universe, that's about all I can give you.



- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTFZkQs1xW0HCTEFAQJs2A//YSjtTW8JR0n+Rz4XrBsib4O1Qgo1CGmd
ybbIQxE1eO8OG/p7uaJuHVaot1CrG6i3+D/hXp5rVAo4hDtnABLCymLtpjGDMM2o
l8tjY2c7qZ2cBwe356xM21eIPXvO0aNy21Etj5mfohtI4OAn0YTdL+tIwDnH/FOH
qLEFB8yXo5ebRRJJByVdnSJzYxzegszwsJk4JchBEuOxHdoA+sX+V/eUCZIUeJ/t
QsKsk5P/ETnPvfEpq2T53wXHba14r+AdbIoxT1q9mKMSZP7KWkn7u5v7J4MGI7JL
/5wWuk9ezjJn9b8ucu4YAJnf1Uojdo06Q6yqIVlB0pg7eGXdJv73lWXet5A4nUoA
VSDHIqJSy7cPkK4JqghbqJO9R0dca8INAhRkkLvj2zEynw6aG2jo90ZGvDzANPzU
QvGbck2uatY88V/Cvyi0XnkdU/cEPjPnx0OC+7yWHVKTF3p/FYuOXSiruBCgmFtX
7ZCMU89ZNhNUED1nMovQQaChqcgbLQdCvaYOhLcNsIkbmt1zUCx1SeTw4+FCxKYZ
qI0YQ/5mv5NQxIdz/kFN8mu0ULxmzTFz4cK3RmELKvxPvbZA+NExV8c99Po9MLSU
obtEbr/s5g11/Vn9DLR5SuA5hSniEcENQkYMAh7JnreYwIGJ/1KS6n6z6jBGcUY6
lkDp86qR3hg=
=Ft1u
-----END PGP SIGNATURE-----
