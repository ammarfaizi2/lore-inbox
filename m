Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVBNXcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVBNXcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVBNX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:29:47 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57495 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261290AbVBNX2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:28:40 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050214231605.GA13969@suse.de>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>
	 <20050214231605.GA13969@suse.de>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 18:28:35 -0500
Message-Id: <1108423715.32293.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 15:16 -0800, Greg KH wrote:
> > I don't see why so much effort goes into improving boot time on the
> > kernel side when the most obvious user space problem is ignored.
> 
> What user space problem is that?

That init scripts with no interdependencies are run sequentially rather
than in parallel.

There was an article from IBM a while back with a neat hack that used a
parallel make to fire off groups of init scripts in parallel.  I would
expect more interest in this from the distros.

Lee

