Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWJCTw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWJCTw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWJCTw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:52:29 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:2502 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1030220AbWJCTw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:52:28 -0400
Date: Tue, 3 Oct 2006 12:49:57 -0700
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003194957.GB17855@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <d120d5000610031208i4a204b2es8de8d424a573acf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000610031208i4a204b2es8de8d424a573acf4@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 03:08:43PM -0400, Dmitry Torokhov wrote:
> On 10/3/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> >
> >       Now it's too late, those changes have propagated to userspace
> >tools, and are now shipping in some actual release of some distro. So,
> >what are we going to say to Mandriva 2007 and FC6 users, to revert
> >back to an *older* version of the tools ?
> >       Because userspace has already been updated, we have only two
> >options, merge it now, or in 2.6.20.
> >
> 
> Are you saying that compatibility is broken both ways?? Not only one
> needs new tools for the new kernels but also has to downgrade tools to
> work with older kernels??

	No, it's not. But as soon as *some part* of WE-21 appears in
the kernel, the userspace expect the ESSID change. If we want to have
WE-21 without the ESSID change, we need to fix userspace.

> Dmitry

	Jean
