Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbUK0DxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUK0DxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUK0Dwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:52:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262524AbUKZTdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:38 -0500
Date: Fri, 26 Nov 2004 01:14:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 49/51: Checksumming
Message-ID: <20041126001432.GM2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300589.5805.392.camel@desktop.cunninghams> <20041125235622.GI2909@elf.ucw.cz> <1101427251.27250.166.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101427251.27250.166.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > A plugin for verifying the consistency of an image. Working with kdb, it
> > > can look up the locations of variations. There will always be some
> > > variations shown, simply because we're touching memory before we get
> > > here and as we check the image.
> > 
> > Debugging code, can live as external patch pretty well.
> 
> Doesn't most of the kernel have debugging code in it? Maybe not as much,
> but most of the kernel isn't doing the same thing. Remember we have the
> option of compiling it out. If it lives as a separate patch, we're just
> making more work for me (I have to maintain the debug version and then
> make some transformation on it to get the mainline version).

There's so much of debuging code that it is unreadable. When it is
separate file it is not so bad, but you'll have 1000 people going over
it "What is this", trying to keep it up-to-date with sparse
annotations etc...

Is not it possible to just debug suspend2 and then drop the debugging
code, not maintaining it any longer?

> By the way, I'm really appreciating your interaction over all these
> points. I was getting worried that I wasn't getting enough. I should say
> now, too, that I'm away all weekend, so you won't get replies tomorrow
> and the day after.

Well, I worry that now you'll be getting way too much
interaction... Anyway have a nice weekend,
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
