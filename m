Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRLLNfJ>; Wed, 12 Dec 2001 08:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280059AbRLLNfA>; Wed, 12 Dec 2001 08:35:00 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:27330 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280029AbRLLNey>; Wed, 12 Dec 2001 08:34:54 -0500
Message-Id: <5.1.0.14.2.20011212133045.02649740@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Dec 2001 13:34:00 +0000
To: Hans Reiser <reiser@namesys.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes 
  interface)
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <3C17474B.3070207@namesys.com>
In-Reply-To: <Pine.SOL.3.96.1011212015827.2712B-100000@draco.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:02 12/12/01, Hans Reiser wrote:
>Anton Altaparmakov wrote:
>>On Wed, 12 Dec 2001, Hans Reiser wrote:
>>>Anton Altaparmakov wrote:
>>>>Both MacOS and as of recently Windows do this kind of stuff, too, and it
>>>>can't be long before Linux goes the same way, provided file systems
>>>>support the required features (i.e. EAs and/or named streams) so I
>>>>disagree with you this is only a compatibility thing. It might start out
>>>>as one but it will find real world applications very quickly...
>>>I am not saying that the features of EAs are not useful, I am saying 
>>>that I want to choose them individually for particular files.
>>>
>>>It could be so much better to have EDIBLE_PIZZA (example from previous 
>>>email) instead of just PIZZA, sigh.
>>
>>I am not quite sure what you mean. Surely you can just have all features
>>available at all times/to all files and then you just use the ones you
>>want, just ignoring/not using the rest. Why do you see the need for
>>"selecting features of EAs individually for particular files"? It makes
>>sense when buying EDIBLE_PIZZA but I don't see how that can be transferred
>>onto files. After all I can just have all pizza ingredients and only put
>>the ones I want on the pizza just ignoring the others.
>Inheriting stat data from the parent directory should be a feature 
>available not just for streams, but for all files that want it. Efficient 
>small file access to a 32 byte file should be a feature available to all 
>files, not just EAs.  Not being listed in readdir should be a feature 
>available to all files, not just EAs.  Constraining what is written to 
>them should be a feature available to all files, not just EAs, and 
>arbitrary plugin based constraints should be possible.
>
>Is this more clear?

Yes it is, thanks. And yes it makes sense. But this is talking about files 
as a whole and has nothing to do with EAs as such (but it would obviously 
apply to EAs, too under your proposed API).

I will be looking forward to seeing this stuff implemented. (-:

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

