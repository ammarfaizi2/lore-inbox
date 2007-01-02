Return-Path: <linux-kernel-owner+w=401wt.eu-S1755347AbXABQMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbXABQMq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXABQMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:12:46 -0500
Received: from thunk.org ([69.25.196.29]:36049 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755347AbXABQMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:12:45 -0500
Date: Tue, 2 Jan 2007 11:12:37 -0500
From: Theodore Tso <tytso@mit.edu>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and v2.6.20-rc3 released))
Message-ID: <20070102161237.GA8562@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com> <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org> <459973F6.2090201@pobox.com> <20070102115834.1e7644b2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102115834.1e7644b2@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 11:58:34AM +0000, Alan wrote:
> This is a slight variant on the patch I posted December 16th to fix
> libata combined mode handling. The only real change is that we now
> correctly also reserve BAR1,2,4. That is basically a neatness issue.

Thanks,

I can confirm that with this patch applied, I can boot 2.6.20-rc3 on
my Thinkpad T60p.  My primary laptop is now running the with the
patch, and I'll start pushing it through its paces.  If start losing
any files or seeing any disk corruption I'll let folks now.

					- Ted
