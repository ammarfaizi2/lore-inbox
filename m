Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWBTTpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWBTTpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWBTTpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:45:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18081 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932659AbWBTTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:45:11 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor_core@ameritech.net, Mark Lord <lkml@rtr.ca>,
       Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060220103329.GE21817@kobayashi-maru.wspse.de>
	 <1140434146.3429.17.camel@mindpipe> <200602202124.30560.nigel@suspend2.net>
	 <20060220132333.GB23277@atrey.karlin.mff.cuni.cz> <43F9D0DC.5080302@rtr.ca>
	 <20060220143041.GB1673@atrey.karlin.mff.cuni.cz>
	 <d120d5000602200641i136d9778uf9049355c39451a9@mail.gmail.com>
	 <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 14:45:04 -0500
Message-Id: <1140464704.6722.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 15:54 +0100, Pavel Machek wrote:
> > I know I am bad for not reporting that earlier but swsusp was
> working
> > OK for me till about 3 month ago when I started getting "soft lockup
> > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > somehow suspect that having automounted nfs helps it to fail
> > somehow...
> 
> Disable soft lockup watchdog :-). 

You do know that message is harmless and doesn't actually do anything
right?  It's just warning you that the kernel allowed something to hog
the CPU without rescheduling for a LONG time.

Lee

