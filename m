Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWJDT6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWJDT6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJDT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:58:05 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:26069 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1750974AbWJDT6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:58:02 -0400
Date: Wed, 4 Oct 2006 12:52:29 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004195229.GA4459@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 12:21:46PM -0700, Linus Torvalds wrote:
> 
> The current situation seems to be designed to add the new one and removing 
> the old one as a single step. THAT IS BROKEN.

	This is not the case, I don't know where you got this
idea. This is a *two* step process with a 6 month interval between the
two steps. This was clearly detailed earlier in this thread.

> The new one and the old one needs to work at the same time, exactly so 
> that there's a transition mechanism.

	Yes, this is precisely what we have been doing, the two APIs
have been working at the same time for more than 6 months.

> > 	That's exactly what it hinges on. What is your criteria for
> > removing the old ESSID API. My understanding was 6 months.
> 
> But we didn't have 6 months of the new API, did we?

	Yes, we had more of 6 months of the new API. Please check the
facts : included April 11th in Gentoo.

> People complained. 

	Yes, maybe 6 months was two short. That's why I say that we
should give it one or two more months. Maybe we need FC6 to be
released.

> The person you merged through explicitly said that if he had realized what 
> you did, he wouldn't have merged.

	I did not merge through Jeff.

> 			Linus

	Jean
