Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291860AbSBARAZ>; Fri, 1 Feb 2002 12:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291858AbSBARAP>; Fri, 1 Feb 2002 12:00:15 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:8926 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S291857AbSBARAH>; Fri, 1 Feb 2002 12:00:07 -0500
Date: Fri, 1 Feb 2002 11:00:06 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201110005.A2560@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <20020201093657.B763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201093657.B763@lynx.adilger.int>; from adilger@turbolabs.com on Fri, Feb 01, 2002 at 09:36:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:36:57AM -0700, Andreas Dilger wrote:
| On Feb 01, 2002  03:17 -0600, Ken Brownfield wrote:
| > Since I've switched to using 2.4 in situations where /dev/random is
| > heavily used, I've been seeing more and more of the running issue with
| > /dev/random.
| > 
| > After a few days of occasional use from sshd and our own cryptographic
| > purposes, we're seeing entropy_avail go to 0 and requests to /dev/random
| > block.  The processes that block remain killable, but entropy no longer
| > appears until a reboot is performed.
| 
| What specific kernel version are you using?  There were some bugs where
| the entropy was /32 on each usage that I fixed.

Yes, which was at least partially Robert's contribution.

I'm seeing this on 2.4.16 and 2.4.18-preN.  It's been there since the
beginning AFAIK.
-- 
Ken.
brownfld@irridia.com


| Cheers, Andreas
| --
| Andreas Dilger
| http://sourceforge.net/projects/ext2resize/
| http://www-mddsp.enel.ucalgary.ca/People/adilger/
