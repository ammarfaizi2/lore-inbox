Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314503AbSDSAK7>; Thu, 18 Apr 2002 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314510AbSDSAK6>; Thu, 18 Apr 2002 20:10:58 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:9461 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314503AbSDSAK6>; Thu, 18 Apr 2002 20:10:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 18 Apr 2002 18:09:28 -0600
To: "Adrian V. Bono" <g_adrian@tmg99.ntes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: something weird on Linux 2.4.17 on an IBM Thinkpad T20
Message-ID: <20020419000928.GB28956@turbolinux.com>
Mail-Followup-To: "Adrian V. Bono" <g_adrian@tmg99.ntes.nec.co.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CBF6225.6050605@tmg99.ntes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2002  09:17 +0900, Adrian V. Bono wrote:
> While working in X on kernel 2.4.17 on an IBM Thinkpad T20, sometimes 
> the mouse pointer would just gravitate all by itself, without my moving 
> the mouse or pointing stick, upwards. The first time that happened, i 
> was coding in an xterm when suddenly, window focus shifted to another 
> window and i noticed the mouse pointer was moving upwards by itself. 
> Anyone else notice this?

This is common to all thinkpads (or other laptops which have trackpoint
devices) and also happens under Windows.  The cause is related to
automatic compensation for the centering of the trackpoint.  Early
trackpoint devices didn't have automatic centering and I remember
replacing more than a few keyboards because the mouse would start
drifting by itself.  Later trackpoints have automatic centering, but
if you hold onto the trackpoint for a long time (causing the "center"
to be offset by some amount) and then let go, it will settle back to
the "old center" and the cursor will drift for a few seconds until
the automatic centering kicks in again.

Moral of the story - don't touch the trackpoint when you aren't doing
anything with it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

