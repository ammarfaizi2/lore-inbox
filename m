Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130950AbRBNTYX>; Wed, 14 Feb 2001 14:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbRBNTYN>; Wed, 14 Feb 2001 14:24:13 -0500
Received: from tux.mkp.net ([130.225.60.11]:5124 "EHLO tux.mkp.net")
	by vger.kernel.org with ESMTP id <S130950AbRBNTX4>;
	Wed, 14 Feb 2001 14:23:56 -0500
To: Michael E Brown <michael_e_brown@dell.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <Pine.LNX.4.30.0102132348560.1882-100000@carthage.michaels-house.net>
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
Date: 14 Feb 2001 09:23:49 -0500
In-Reply-To: <Pine.LNX.4.30.0102132348560.1882-100000@carthage.michaels-house.net>
Message-ID: <yq13ddh2vii.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Canyonlands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael E Brown <michael_e_brown@dell.com> writes:

Michael,

Michael> It looks like the numbers we picked for our respective IOCTLs
Michael> conflict.  I think I can change mine to the next higher since
Michael> your patch seems to have been around longer. 

If you could pick another number that would be great.  All the people
out there using XFS rely on the BLKSETSIZE ioctl, and mkfs.xfs would
break horribly with your patch.


Michael> What is the general way to deal with these conflicts?

Whoever applies the patch to the official tree deals with them :)

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/
