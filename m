Return-Path: <linux-kernel-owner+w=401wt.eu-S964865AbWLNWXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWLNWXX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWLNWXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:23:22 -0500
Received: from smtp-server.carlislefsp.com ([12.28.84.26]:46996 "EHLO
	smtp-server.carlislefsp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964865AbWLNWXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:23:22 -0500
X-Archive-Filename: imail11661350006917070 
X-Qmail-Scanner-Mail-From: stever@carlislefsp.com via imail
X-Qmail-Scanner: 1.24st (Clear:RC:1(10.10.3.184):. Processed in 0.03556 secs Process 7070)
Message-ID: <4581CE94.5000900@carlislefsp.com>
Date: Thu, 14 Dec 2006 16:22:12 -0600
From: Steve Roemen <stever@carlislefsp.com>
Reply-To: stever@carlislefsp.com
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
CC: "Frazier, Daniel Kent" <daniel_frazier@hp.com>,
       Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>,
       ISS StorageDev <iss_storagedev@hp.com>
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
References: <E717642AF17E744CA95C070CA815AE55F6F0C3@cceexc23.americas.cpqcorp.net>
In-Reply-To: <E717642AF17E744CA95C070CA815AE55F6F0C3@cceexc23.americas.cpqcorp.net>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yes,  32bit Debian

Miller, Mike (OS Dev) wrote:
> 
>
>> -----Original Message-----
>> From: Frazier, Daniel Kent
>> Sent: Thursday, December 14, 2006 3:12 PM
>> To: Miller, Mike (OS Dev)
>> Cc: Jens Axboe; Steve Roemen; LKML; ISS StorageDev
>> Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
>>
>> On Thu, Dec 14, 2006 at 01:44:34PM -0600, Miller, Mike (OS Dev) wrote:
>>> 
>>>
>>>> -----Original Message-----
>>>> From: Jens Axboe [mailto:jens.axboe@oracle.com]
>>>> Sent: Thursday, December 14, 2006 12:51 PM
>>>> To: Steve Roemen
>>>> Cc: LKML; ISS StorageDev; Miller, Mike (OS Dev)
>>>> Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
>>>>
>>>> On Thu, Dec 14 2006, Steve Roemen wrote:
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> All,
>>>>>     I tried out the 2.6.19-git20 kernel on one of my
>> machines (HP
>>>>> DL380 G3) that has the on board 5i controller (disabled),
>>>>> 2 smart array 642 controllers.
>>>>>
>>>>> I get the error (cciss: cmd f7b00000 timedout) with Buffer
>>>> I/O error
>>>>> on device cciss/c (all cards, and disks) logical block 0, 1, 2,
>>>>> etc
>>>> I saw this on another box, but it works on the ones that I have.
>>>> Does
>>>> 2.6.19 work? Any chance you can try and narrow down when it broke?
>>> Jens/Steve:
>>> We also encountered a time out issue on the 642. This one
>> is connected
>>> to an MSA500. Do either of you have MSA500? What controller
>> fw are you
>>> running? Check /proc/driver/cciss/ccissN.
>> fyi, we've been seeing this in Debian too (which is why Mike
>> added me to the CC list), and I've narrowed it down to the
>> 2TB patch that went into 2.6.19:
>>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=402787
>
> Hmmmm. Dann, did you see this on 32-bit Debian? I have this running in
> the lab on x86_64 and ia64. Someone else was _supposed_ to test ia32 for
> me. Dammit.
>
> Jens/Steve:
> Are your os'es 32-bit?
>
> mikem
>
>
>> --
>
>
>> dann frazier | HP Open Source and Linux Organization
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgc6UcA4cgQlZoQ8RAnRHAKDRshyyEIJTECKRTe/ghkNNkC8a0QCfQYnO
To0nPyou9F3OWbyxzTnZ5JU=
=0z54
-----END PGP SIGNATURE-----

