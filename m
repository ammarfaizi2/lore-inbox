Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWJCMnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWJCMnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWJCMnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:43:18 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:37903 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932081AbWJCMnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:43:17 -0400
Date: Tue, 3 Oct 2006 08:38:42 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003123835.GA23912@tuxdriver.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159807483.4067.150.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 12:44:42PM -0400, Lee Revell wrote:
> On Mon, 2006-10-02 at 09:21 +0000, Alessandro Suardi wrote:
> >   we've been just through an email thread where it has been
> >   determined that wpa_supplicant 0.4.9 (I would assume that
> >   0.5.5 is also okay) and wireless-tools from Jean's latest
> >   tarball are necessary to work with the recent wireless
> >   extensions v21 that have been merged in.
> > 
> > What wireless-tools are you using ? 
> 
> This must be considered a kernel bug - it's not allowed to break
> userspace compatibility in a stable series.

But there is no development series.  The closest thing we have is the
merge window after each release -- which is exactly when this issue
revealed itself.

Wireless in general (and the wireless extensions api in particular)
is a bit of a 'whipping boy' in the Linux world.  OK, we suck.
Everyone wants to display their wisdom by telling us how much we suck!
We know all about it...

We have sucked, and we continue to suck -- and we are working on it.
But, we are not going to be able to whip-up this omelette without
breaking a few eggs.  If we can't do that during the merge windows,
WHEN CAN WE DO IT?

John
-- 
John W. Linville
linville@tuxdriver.com
