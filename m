Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272514AbRH3WEr>; Thu, 30 Aug 2001 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272518AbRH3WEh>; Thu, 30 Aug 2001 18:04:37 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27380
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272514AbRH3WEc>; Thu, 30 Aug 2001 18:04:32 -0400
Date: Thu, 30 Aug 2001 15:04:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs: how to mount without journal replay?
Message-ID: <20010830150444.C1451@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL> <20010830225323.A18630@atrey.karlin.mff.cuni.cz> <3B8EAD35.5695B30B@namesys.com> <20010830235005.B9330@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830235005.B9330@bug.ucw.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 11:50:05PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Then suse's  use of reiserfs is pretty b0rken. Putting reiserfsck on /
> > > partition is pretty useless -- if it crashes during mount you can't
> > > repair it.
> > 
> > Every filesystem has this problem, if the root directory gets hosed you have to
> > use the CDROM.
> > Booting from CDROM with SuSE is not such a problem.
> 
> ext2 is willing to mount ro even with known inconsistencies. SuSE 7.1
> does not come with 'live filesystem' and install cd does not have
> reiserfsck on it. Too bad. You have to install somewhere to be able to
> run reiserfsck on suse7.1.

Hmm.  Is there any chance of *not* replaying the log on mount-ro, and using
a combination of on disk meta-data, and journal?
