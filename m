Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281855AbRKWBMc>; Thu, 22 Nov 2001 20:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRKWBMX>; Thu, 22 Nov 2001 20:12:23 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:1777 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281852AbRKWBMM>;
	Thu, 22 Nov 2001 20:12:12 -0500
Date: Thu, 22 Nov 2001 18:11:25 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Robert Love <rml@tech9.net>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
Message-ID: <20011122181125.S1308@lynx.no>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Ryan Cumming <bodnar42@phalynx.dhs.org>,
	linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain> <1006472754.1336.0.camel@icbm> <E16744i-0004zQ-00@localhost> <1006476685.1331.9.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1006476685.1331.9.camel@icbm>; from rml@tech9.net on Thu, Nov 22, 2001 at 07:51:22PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2001  19:51 -0500, Robert Love wrote:
> I would suggest letting users set their own affinity (since it only
> lessens what they can do) and let a capability dictate if non-root users
> can set other user's tasks affinities.  CAP_SYS_ADMIN would do fine.

Rather use something else, like CAP_SYS_NICE.  It ties in with the idea
of scheduling, and doesn't further abuse the CAP_SYS_ADMIN capability.
CAP_SYS_ADMIN, while it has a good name, has become the catch-all of
capabilities, and if you have it, it is nearly the keys to the kingdom,
just like root.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

