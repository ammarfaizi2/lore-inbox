Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVBOHcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVBOHcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 02:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVBOHcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 02:32:41 -0500
Received: from b.relay.invitel.net ([62.77.203.4]:64412 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP id S261645AbVBOHcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 02:32:39 -0500
Date: Tue, 15 Feb 2005 08:32:22 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Message-ID: <20050215073222.GB26950@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
X-Operating-System: vega Linux 2.6.10-2-686 i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 08:45:39PM -0500, Kyle Moffett wrote:
> >last thing that gets run.  There is just no reason for this.  We should
> >start X and initialize the display and get the login prompt up there
> >ASAP, and let the system acquire the DHCP lease and start sendmail and
> >apache and get the date from the NTP server *in the background while I
> >am logging in*.  It's not rocket science.
> 
> Such a system needs a drastically different bootup process than 
> currently
> exists, including the ability to specify init-script dependencies.  
> (Like

Ok, so see Gentoo. Exactly fits your needs, it seems ;-) Dependencies are
supported, even paralell execution of init scripts are supported by default
design (you need to change only one setting to do this, IMHO, in
/etc/conf.d/rc). So it is already solved if you talking about the paralell
execution with dependency info in init scripts ...

Also the smf ability of Solaris10 seems to be interesting, but I don't want
to talk about it, since I have no time to see it in action, I've only read
about it, so ...

- Gábor
