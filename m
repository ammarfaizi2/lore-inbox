Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbTCLTCO>; Wed, 12 Mar 2003 14:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbTCLTCO>; Wed, 12 Mar 2003 14:02:14 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:65021 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261848AbTCLTCN>; Wed, 12 Mar 2003 14:02:13 -0500
Date: Wed, 12 Mar 2003 12:12:09 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Ben Collins <bcollins@debian.org>
Cc: Arador <diegocg@teleline.es>, lm@work.bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312121209.L12806@schatzie.adilger.int>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Arador <diegocg@teleline.es>, lm@work.bitmover.com,
	linux-kernel@vger.kernel.org
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312193806.2506042c.diegocg@teleline.es> <20030312184710.GI563@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312184710.GI563@phunnypharm.org>; from bcollins@debian.org on Wed, Mar 12, 2003 at 01:47:10PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 12, 2003  13:47 -0500, Ben Collins wrote:
> You're missing the point. I am not against the CVS->BK gateway. I'm all
> for it. But it's kind of sour given that he now wants to change the disk
> format of the repo to make it harder to get the data from it.

Actually, that is purely YOU reading something into what he wrote.  He
didn't say "now I'm going to make the repo harder to get data from it".
What he said was "now I'm free to change the format from SCCS to something
that is more efficient for BK to use".  Who knows, maybe the new format
will be _easier_ to reverse engineer/parse using 3rd party tools?

Also, it's not like he can change things overnight, because there are lots
of customers/users who have repos in the old SCCS format, and he doesn't
want to completely throw away his current code just to piss off some whiny
l-k users.  At worst, if it bothers you so much, you can take up the now
seemingly forgotten Linux trait of "taking things into your own hands and
fixing it to your own needs" and write bk_evil_format_2_CVS conversion tool
instead of bitching on l-k about it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

