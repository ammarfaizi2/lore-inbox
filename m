Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWAIQOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWAIQOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWAIQOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:14:38 -0500
Received: from mail1.kontent.de ([81.88.34.36]:61398 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932429AbWAIQOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:14:37 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 17:14:27 +0100
User-Agent: KMail/1.8
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <5t06S-7nB-15@gated-at.bofh.it> <200601091702.48955.oliver@neukum.org> <1136822646.9957.35.camel@mindpipe>
In-Reply-To: <1136822646.9957.35.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091714.27303.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Januar 2006 17:04 schrieb Lee Revell:
> On Mon, 2006-01-09 at 17:02 +0100, Oliver Neukum wrote:
> > Am Montag, 9. Januar 2006 16:15 schrieb Lee Revell:
> > > On Mon, 2006-01-09 at 15:28 +0100, Oliver Neukum wrote:
> > > > Am Montag, 9. Januar 2006 15:18 schrieb Robert Hancock:
> > > > > Yaroslav Rastrigin wrote:
> > > > > > Well, I could find more or less reasonable explanation of this behaviour - different VM policies of two OSes and 
> > > > > > strangely strong and persistent belief "Free RAM is a wasted RAM" among kernel devs. Free RAM is not a wasted RAM, its a memory waiting to be used ! 
> > > > > > Whenever it is needed by apps I'm launching or working with. 
> > > > > 
> > > > > There is no different VM policy here, Windows behaves quite similarly. 
> > > > > It does not leave memory around unused, it uses it for disk cache.
> > > > 
> > > > That doesn't mean that the rate of eviction is the same.
> > > > Is it possible that read-ahead is not aggressive enough?
> > > 
> > > Enough for what?  What is the exact problem you are trying to solve?
> > 
> > Quicker application startup.
> 
> Why do you look to the kernel first?  The obvious explanation is that
> Linux desktop apps are more bloated than their Windows counterparts.

It is the most efficient place. An improvement to the kernel will improve
all starting times.

	Regards
		Oliver
