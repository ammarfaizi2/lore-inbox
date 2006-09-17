Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWIQSrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWIQSrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWIQSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 14:47:17 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:1699 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932340AbWIQSrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 14:47:17 -0400
Message-ID: <450D9831.20205@comcast.net>
Date: Sun, 17 Sep 2006 14:47:13 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler tunables?
References: <450C8680.6050904@comcast.net>	 <1158483845.6025.22.camel@Homer.simpson.net> <450D6786.7010404@comcast.net> <1158520745.6086.6.camel@Homer.simpson.net>
In-Reply-To: <1158520745.6086.6.camel@Homer.simpson.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Mike Galbraith wrote:
> On Sun, 2006-09-17 at 11:19 -0400, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>>
>> Mike Galbraith wrote:
>>> On Sat, 2006-09-16 at 19:19 -0400, John Richard Moser wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> It looks like the scheduler tunables have been removed from 2.6
>>>> somewhere before 2.6.17. 
>>> Which tunables are you referring to?
>>>
>>>
>> http://kerneltrap.org/node/525
>>
>> The relevant code changes in sysctl.h and sched.c seem to be undone.  Of
>> course I'm assuming my distribution didn't just add a side patch in at
>> the time when I noticed these existed so long ago.
> 
> Ah.  These knobs were never exported in a standard kernel.  I believe
> there was a patch recently (couple weeks ago?) posted to export them
> again for experimentation.  A search of the archives should turn it up.
> 

Nods.  May be good in environments where longer time slices could be a
significant performance enhancement.


> 	-Mike
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRQ2YLgs1xW0HCTEFAQJO8hAAm/ycdiOe4oEY0kUwf6irUj9FHQ/zOhJe
jLIvBqE60GnyP7Ry8Xk1vA9CM009xrbY2uYPyFmlSaiydPqkaganaCkAIS3deg1z
EIT85MQCY6YHkUxOnjNScIkylSjr0jy3aDQtz0aNU1TAbnyYPwZyAAKU1N3ouwMG
M0PPZqQTUiRM6IKbNgFENpx83VopovFmBLtWRXFGj4n6dPx1SjB7gSRbUlJ4oKNl
4wHb06uZgV4pCJaKJv3h8yLmtepVleRMVA4QwIvTql4UizaX8XQt6hfhxtpoIAbD
fBDZ/wtD4rqUiMFiB9Y0nb2OQmQLS1bWwfXjXU/ZsJdz+zSe1qC3TLfwkL4Sjhxo
cC8HjOJyjo1vU0GT/Pq11JY2jvbbPlkbmk8VTV7g7+E602wfg+BLjcmKlN6scl6T
rkCy824HFnxCXlldvHXqxq2My/Ys7HQFK92QuMdRrQF3AkPKKtLwAEJHZh+hW1oB
N15XFXXN6SgP69UiRGBo6+QyZHTjmHlw+nNgBBBFrRwvr10NYVCV/el+e7eGY8hC
YWy+wIqMEN51F6NEPsdSUg0od94mlc6waER6gMgxnFZMVR4TzTfKtDogqW28dRSp
AoaXY7TynFt2K1d3iOlk7OtiX9R+U1WxDrAeNlPm/meeJjbSD8ClsqhNPbzunO0E
/GeJOByK/o8=
=zYrn
-----END PGP SIGNATURE-----
