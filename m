Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284246AbRLLAAz>; Tue, 11 Dec 2001 19:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284243AbRLLAAi>; Tue, 11 Dec 2001 19:00:38 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:57865 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284200AbRLLAAY>; Tue, 11 Dec 2001 19:00:24 -0500
Message-ID: <3C169DCD.8060806@namesys.com>
Date: Wed, 12 Dec 2001 02:59:09 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
CC: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <Pine.SOL.3.96.1011211225917.17160A-100000@libra.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>
>I was just stating a fact of how they are stored on NTFS, again something
>I have no power to change.
>
But does NTFS specificism/cripplism belong in VFS?  (I in no way blame 
you for NTFS's design:-) )

>>Well, gosh, okay, maybe you want to prepend ',,' to streams and '..' to 
>>extended attributes.  I personally think Linux would only want to do so 
>>when used as a fileserver emulating NTFS/SAMBA.  There is no enhancement 
>>of user functionality from doing it for general purpose filesystems. 
>>
>
>Just wait until this functionality is available and watch all GUI things
>start to use it en masse! I don't doubt that GNOME/KDE/replace with your
>favourite window manager are going to hesitate to start putting in the
>icon, the name, and whatnot inside EAs or inside named streams the instant
>they are ubiquitously available and I think that makes a lot of sense too.
>No doubt I will get flamed for saying this but all flames go to
>/dev/null...
>
>Both MacOS and as of recently Windows do this kind of stuff, too, and it
>can't be long before Linux goes the same way, provided file systems
>support the required features (i.e. EAs and/or named streams) so I
>disagree with you this is only a compatibility thing. It might start out
>as one but it will find real world applications very quickly...
>
I am not saying that the features of EAs are not useful, I am saying 
that I want to choose them
individually for particular files.

It could be so much better to have EDIBLE_PIZZA (example from previous 
email)
instead of just PIZZA, sigh.

>
>
>
>>>
>>Programs will get written to use your API, and not work with reiserfs, 
>>and will get written to use our API and not work with NTFS, and this is 
>>bad....
>>
>
>Now that is true. And yes, it is bad. However it will be up to the
>community to decide which API to use and at the moment there are several
>fs using the "bestbits" API and only reiserfs (?) the "reiserfs" one...
>And we all know from our very own $Deity that we don't design software, we
>just write things and let evolution decide which is better. (((-;
>
Fortunately he isn't entirely consistent on this point.:-)

I predict you guys will ship first and get a lot of usage, and then we 
will ship later with more features,
and the result will be a mess for users.  This is the usual evolutionary 
design standards mess.  
Objectively, I understand it is highly reasonable for the Linux 
community to assume that what we
implement will be horrible until we finish it.  I would encourage it to 
assume that someone else
will eventually get orthogonalism right though, and I think it would be 
worth waiting for it, because
these are the sorts of design features that stick around for 30 years. 
 I don't really expect that most
folks will choose to wait though.

Best to all,

Hans


