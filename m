Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWJDVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWJDVTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWJDVTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:19:39 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:53006 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751139AbWJDVTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:19:39 -0400
Date: Wed, 4 Oct 2006 17:08:18 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004210813.GC9277@tuxdriver.com>
References: <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org> <20061004195229.GA4459@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004195229.GA4459@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 12:52:29PM -0700, Jean Tourrilhes wrote:
> On Wed, Oct 04, 2006 at 12:21:46PM -0700, Linus Torvalds wrote:

> > The person you merged through explicitly said that if he had realized what 
> > you did, he wouldn't have merged.
> 
> 	I did not merge through Jeff.

You did, just indirectly.  I was directly upstream from you.

For the record, I did not fully comprehend that we would be breaking
existing tools (and their users) -- I certainly should have, but I
did not.  I apologize both to you for being part of this scenario I
inadvertantly allowed to unfold and to the users who experienced the
resulting breakage.

This was the second time I took patches for extending WE, and I have
received nothing but grief from either set of patches.  Even had
things gone smoothly, WE was already hated near universally.  WE has
survived based on being "good enough" for a long time.  But I think
it is safe to say that if WE were not already in the kernel, it would
have little chance of making it in today.

All the legitimate options for extending WE now amount to forking a
new API.  But work is already underway on a WE replacement.  I think
the best option is to invest in that replacement, and a compatibility
layer to support older WE-aware applications.  Please see the nl80211
and cfg80211 currently on the netdev list.

I do not intend or expect to take any more WE enhancment patches.
Only bug fixes to WE will be accepted from now onward.

Jean, I thank you for your long-running contributions.  I hope this
will not discourage you from further participation.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
