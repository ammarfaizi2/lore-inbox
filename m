Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUK3Wnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUK3Wnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUK3Wni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:43:38 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:13698 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262370AbUK3Wii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:38:38 -0500
Date: Tue, 30 Nov 2004 23:38:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 49/51: Checksumming
Message-ID: <20041130223823.GA1522@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300589.5805.392.camel@desktop.cunninghams> <200411290455.10318.rob@landley.net> <200411290455.10318.rob@landley.net> <20041130130227.GA4670@openzaurus.ucw.cz> <E1CZ8DU-0005n5-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CZ8DU-0005n5-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, it would be good sanity check. ext3 replays journals even on
> > read-only mount so your / will need to be ext2...
> 
> The alternative is to have a userspace application that can check these
> things without having to replay the log.

Well, that works as long as you do not have your application on ext3
filesystem :-). If your root filesystem is ext2, you have no problem,
and whether or not checking is done in kernelspace does not matter.

Well, you could probably mount ext3 as read-only ext2...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
