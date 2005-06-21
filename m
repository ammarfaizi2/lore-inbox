Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFUOg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFUOg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFUOei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:34:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62098 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262097AbVFUObq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:31:46 -0400
Date: Tue, 21 Jun 2005 16:28:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050621142820.GC2015@openzaurus.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >     This is useful, but there are, AFAIK, two issues:
> > 
> >     - We're still deadlocked over some permission-checking hacks in there
> 
> Oh, god.  Let me try to explain this again:
> 
>   - This is a security issue with unprivileged mounts

Pretty please, just merge it without  unpriviledged mounts. I see they are
usefull,
but they are too strange for now. If user tries mounting themselves,
he gets -EPERM, and applies 10-liner from you. Does not look like "fork" or
anything serious.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

