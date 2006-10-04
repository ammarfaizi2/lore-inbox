Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWJDAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWJDAbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWJDAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:31:36 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:62178 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1161001AbWJDAbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:31:34 -0400
Date: Tue, 3 Oct 2006 17:30:31 -0700
To: Sean <seanlkml@sympatico.ca>
Cc: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004003031.GA2215@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <20061003233138.GA2095@bougret.hpl.hp.com> <20061003202754.ce69f03a.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003202754.ce69f03a.seanlkml@sympatico.ca>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:27:54PM -0400, Sean wrote:
> On Tue, 3 Oct 2006 16:31:38 -0700
> Jean Tourrilhes <jt@hpl.hp.com> wrote:
> 
> > 	It's already done with the current interface, you can access
> > the API with either ioctls or RtNetlink.
> 
> Does this answer Ted's question though?  Why can't userspace request
> the new v48 interface to get the changed API while older tools
> get the v47 interface and continue to work without needing to
> be upgraded?

	How does that happen in practice ? Kernel has no clue on what
userpace version is running.

> Sean

	Jean
