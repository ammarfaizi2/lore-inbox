Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154983AbQECHBx>; Wed, 3 May 2000 03:01:53 -0400
Received: by vger.rutgers.edu id <S155209AbQECG63>; Wed, 3 May 2000 02:58:29 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4904 "EHLO pneumatic-tube.sgi.com") by vger.rutgers.edu with ESMTP id <S155541AbQECG5g>; Wed, 3 May 2000 02:57:36 -0400
Message-ID: <390FCFA2.A71B9C3@sgi.com>
Date: Wed, 03 May 2000 00:05:06 -0700
From: Linda Walsh <law@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH] (for 2.3.99pre6) audit_ids system calls
References: <200005030228.e432SVZ12218@jupiter.cs.uml.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu

"Albert D. Cahalan" wrote:
> I think I know what he means.
> 
> For "real security" you don't pretend that you can stop spies.
> The system is strictly DAC-based, and most likely uses a root
> account in the traditional way. Instead of adding new features,
> you verify that the existing ones work correctly. An LSPP/B1
> system full of bugs is worse than a perfect not-quite-C2 system.
> The latter will at least correctly enforce DAC, while the former
> might well let remote attackers get into kernel memory.
---
	Absolutely agree.  A DAC Protection Profile, if evaluated to
"EAL" (Evaluated Assurance Level) anything is better than an untested
system.  However, CAPP and LSPP both specify an EAL of "3".  This means
that their feature set has been Evaluated to meet a well-defined Level
of Assurance (documentation, testing, build methodology, code management,
some level of proof that the features provided meet the functional specs,
etc). We've seen distro's ship binary disks where the images on the disk
didn't match what was in the source.  We don't know what version of the
compiler was used, etc.  We don't know what was in those
binaries -- there's no third party evaluation, no standard measured
against.

	Under Common Criteria, Functional specifications are separate
from Assurance Levels.  In a given Protection Profile both a set
of functional specs is given as well as a set of Assurance requirements.

The Assurance requirements are covered in Part 3 of the Common Criteria
documents (ISO standard 15408).  The CC.org site seems to be down, so you
find more info at http://csrc.nist.gov/cc/ccv20/ccv2list.htm .  
The Common Criteria isn't just a Dod/US gov. thing.  It's also an ISO 
standard.  But wait, there's more -- if you call now you get these
free Ginsu Steak Knives *and* a Linux Security Policy for the unbelievable
low price...Goddess it's late...I think I better end this...:-)

Bon nuit & Au revoir,
-l

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
