Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbRFMJfh>; Wed, 13 Jun 2001 05:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbRFMJfb>; Wed, 13 Jun 2001 05:35:31 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9476 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262660AbRFMJeo>;
	Wed, 13 Jun 2001 05:34:44 -0400
Message-ID: <20010613001019.A23173@bug.ucw.cz>
Date: Wed, 13 Jun 2001 00:10:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Mich=E8l_Alexandre_Salim?= <salimma1@yahoo.co.uk>,
        Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Clock drift on Transmeta Crusoe
In-Reply-To: <20010611223357.A959@bug.ucw.cz> <20010612210048.20746.qmail@web3505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: =?iso-8859-1?Q?=3C20010612210048=2E20746=2Eqmail=40web3505=2Email=2Eyaho?=
 =?iso-8859-1?Q?o=2Ecom=3E=3B_from_Mich=E8l_Alexandre_Salim_on_Tue=2C_Jun?=
 =?iso-8859-1?Q?_12=2C_2001_at_10:00:48PM_+0100?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Let me guess: vesafb?
> I am running vesafb, yes...
> 
> > If problem goes away when you stop using framebuffer
> > (i.e. go X), then
> > it is known. 
> but the problem happens in X as well :)

So that's different problem.

> > You are lucky. My machine is able to loose 2 minutes
> > from every 3
> > minutes.
> 
> Indeed :) Thanks, it seems like mine is just a normal
> drift.

My 2-minutes-from-3-lost problem is caused by heavy scrolling in
vesafb. It is known console bug. X can not cause that!
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
