Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTFMGTt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbTFMGTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:19:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63757 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265166AbTFMGTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:19:48 -0400
Date: Fri, 13 Jun 2003 08:30:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030613063052.GA1558@zaurus.ucw.cz>
References: <20030613033703.GA526@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613033703.GA526@zip.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Not too sure which list to send this to exactly so here goes. I go
> my laptop back from warranty repair and it was returned with an old
> version of the bios that still had suspend-2-disk capability in it.
> Having set everything up I hit the suspend button and all seemed to
> go ok upto a point:
...
> =
>  stopping tasks failed (2 tasks remaining)
> Suspend failed: Not all processes stopped!
> Restarting tasks...<6> Strange, rpciod not stopped
>  Strange, lockd not stopped

NFS needs "refrigerator" support for 
its kernel threads.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

