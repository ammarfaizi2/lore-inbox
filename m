Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSBZXRk>; Tue, 26 Feb 2002 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288086AbSBZXRa>; Tue, 26 Feb 2002 18:17:30 -0500
Received: from cdserv.meridian-data.com ([206.79.177.152]:44807 "EHLO
	nasexs1.meridian-data.com") by vger.kernel.org with ESMTP
	id <S288019AbSBZXQX>; Tue, 26 Feb 2002 18:16:23 -0500
Message-ID: <2D0AFEFEE711D611923E009027D39F2B153AD6@cdserv.meridian-data.com>
From: "Dennis, Jim" <jdennis@snapserver.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolabs.com>
Cc: "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: crypto (was Re: Congrats Marcelo,)
Date: Tue, 26 Feb 2002 15:18:56 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Andreas Dilger wrote:
>> On Feb 26, 2002  12:38 -0800, Dennis, Jim wrote:
>>>  Now I need to know about the status of several unofficial patches:

>>>       i2c
>>>       Crypto
>>>       FreeS/WAN KLIPS
>>>       LIDS
 
>> No idea.

> I would -love- to see crypto in the mainstream kernel.  Distribution of
> crypto software on kernel.org has been OK for a while now.

> Who knows what the kerneli guys, freeswan, etc. guys think.

> IMO it's time to get a good IPsec implementation in the kernel...

>	Jeff

 I think some people may have misinterpreted my question.  I was actually 
 asking about how soon the maintainers of these unofficial patches will
 be updating their patches to apply cleanly to 2.4.18 (and hopefully in
 conjunction with one another).  I wasn't actually asking when or if these
 would be merged into the mainstream.

 I understand that XFS is not slated for 2.4.x merging; and I presume that
the
 ACL and extended ACL stuff is also slated to remain separate.  I also
understand
 the wariness of the kernel maintainers regarding any inclusion of the
crypto
 code in mainstream given the ongoing U.S. and international political and
legal
 issues that are STILL associated with it.  (Who was it who said that
"reform
 is the enemy of revolution" --- like it or not that seems to be the case
with
 U.S. crypto policy; they've opened the doors enough for most practical
purposes
 leaving a spectre of doubt that they may still have the "right" to control
 the use and export of future cryptographic --- and by extension *other*
software
 --- technologies).  So I understand that the international and KLIPS
patches will
 probably be "unofficial" for the foreseeable future.

 The i2c work seems like a good candidate for inclusion (since lmsensors is
*THE*
 major user of these APIs and it requires the new version.

 As for LIDS, grsecurity, etc: I suspect it will be a cold day in hell
before Linus
 includes any of those into the mainstream.  I think it is sufficient that
he's willing 
 to accommodate the LSM (security module) to provide a common interface to
all of the 
 competing kernel hardening packages.  (I think a bit of consolidation
between the 
 international crypto patch and the LIDS patches might be in order, are they
each
 defining their own versions of the common hashing and encryption
algorithms?).

 The rmap patches are the ones which I would expect to cause the most
debate.  On the
 one hand it seems that they have significant performance and robustness
benefits
 (when the system is pushed to VM pressure) on the other hand I could
understand that
 Marcelo might be VERY reluctant to make such a deep change in a "stable"
series.
 (Linus took a lot of flack for earlier 2.4 VM changes and *he's* the
benevolent
 dictator! --- one can only imagine what will happen to any mortal that
would tempt
 fate so audaciously).  (Anyway, it seems to be a non-issue since you say
that Rik
 isn't even proposing their inclusion; I guess he has just been waiting for
an appropriate
 merge point in 2.5)

 So, I just wanted to know when the (minor) unofficial patches were getting
updated.
 Actually what I'd like is a focal point, perhaps a web site like the old
"big Mama" 
 patches (that Kurt Hewig? used to maintain), which would track and merge
these collections
 of unofficial patches.

 I'll check the FOLK (folk.sourceforge.net) pages ... [click, click]
 ... O.K. those were updated for 2.4.18rc2 so I guess they'll probably be
pretty durn
 close.

 Hmmm.  It seems that I'm rambling and wasting everyone's visual bandwidth.
I'll go 
 away now.  ;)



