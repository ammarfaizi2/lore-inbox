Return-Path: <linux-kernel-owner+w=401wt.eu-S1750810AbWLNTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWLNTjq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWLNTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:39:46 -0500
Received: from smtp-server.carlislefsp.com ([12.28.84.26]:33274 "EHLO
	smtp-server.carlislefsp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbWLNTjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:39:45 -0500
X-Archive-Filename: imail116612518469126385 
X-Qmail-Scanner-Mail-From: stever@carlislefsp.com via imail
X-Qmail-Scanner: 1.24st (Clear:RC:1(10.10.3.184):. Processed in 0.029983 secs Process 26385)
Message-ID: <4581A83C.2090803@carlislefsp.com>
Date: Thu, 14 Dec 2006 13:38:36 -0600
From: Steve Roemen <stever@carlislefsp.com>
Reply-To: stever@carlislefsp.com
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>, iss_storagedev@hp.com,
       mike.miller@hp.com
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
References: <45819939.3030701@carlislefsp.com> <20061214185112.GG5010@kernel.dk>
In-Reply-To: <20061214185112.GG5010@kernel.dk>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

2.6.19 does the same thing, except it's a cmd f7f00000 timedout error.

2.6.18 works just fine though.

Steve

Jens Axboe wrote:
> On Thu, Dec 14 2006, Steve Roemen wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> All,
>>     I tried out the 2.6.19-git20 kernel on one of my machines (HP
>> DL380 G3) that has the on board 5i controller (disabled),
>> 2 smart array 642 controllers.
>>
>> I get the error (cciss: cmd f7b00000 timedout) with Buffer I/O error
>> on device cciss/c (all cards, and disks) logical block 0, 1, 2, etc
>
> I saw this on another box, but it works on the ones that I have. Does
> 2.6.19 work? Any chance you can try and narrow down when it broke?
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgag7cA4cgQlZoQ8RAiXhAJ9eRe0Nh3JqFKO2H6iYKmxsVIKGDACgrCrx
QWG2sAQH4bL8+fa5mPnVhnM=
=DxGc
-----END PGP SIGNATURE-----

