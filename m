Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272515AbRH3Vwr>; Thu, 30 Aug 2001 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272498AbRH3Vvj>; Thu, 30 Aug 2001 17:51:39 -0400
Received: from [194.213.32.137] ([194.213.32.137]:43012 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272516AbRH3Vv3>;
	Thu, 30 Aug 2001 17:51:29 -0400
Message-ID: <20010830235005.B9330@bug.ucw.cz>
Date: Thu, 30 Aug 2001 23:50:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Nikita Danilov <Nikita@namesys.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, research@suse.de
Subject: Re: Reiserfs: how to mount without journal replay?
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL> <20010830225323.A18630@atrey.karlin.mff.cuni.cz> <3B8EAD35.5695B30B@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B8EAD35.5695B30B@namesys.com>; from Hans Reiser on Fri, Aug 31, 2001 at 01:16:37AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  > For recovering broken machine, I'd like to mount without replaying journal.
> > >
> > > You cannot mount without replaying even in read-only mode, because
> > > file-system meta-data are possibly inconsistent.
> > 
> > Then suse's  use of reiserfs is pretty b0rken. Putting reiserfsck on /
> > partition is pretty useless -- if it crashes during mount you can't
> > repair it.
> 
> Every filesystem has this problem, if the root directory gets hosed you have to
> use the CDROM.
> Booting from CDROM with SuSE is not such a problem.

ext2 is willing to mount ro even with known inconsistencies. SuSE 7.1
does not come with 'live filesystem' and install cd does not have
reiserfsck on it. Too bad. You have to install somewhere to be able to
run reiserfsck on suse7.1.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
