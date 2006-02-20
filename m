Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWBTK4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWBTK4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWBTK4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:56:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14524 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964879AbWBTK4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:56:33 -0500
Date: Mon, 20 Feb 2006 11:56:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220105617.GF16042@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz> <20060220094728.GD19293@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220094728.GD19293@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 10:47:28, Matthias Hensler wrote:
> On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> > Only feature I can't do is "save whole pagecache"... and 14000 lines
> > of code for _that_ is a bit too much. I could probably patch my kernel
> > to dump pagecache to userspace, but I do not think it is worth the
> > effort.
> 
> I do not think that Suspend 2 needs 14000 lines for that, the core is
> much smaller. But besides, _not_ saving the pagecache is a really _bad_
> idea. I expect to have my system back after resume, in the same state I
> had left it prior to suspend. I really do not like it how it is done by
> Windows, it is just ugly to have a slowly responding system after
> resume, because all caches and buffers are gone.

That's okay, swsusp already saves configurable ammount of pagecache.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
