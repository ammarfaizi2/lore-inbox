Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUK1XkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUK1XkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUK1XkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:40:10 -0500
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:18565 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261605AbUK1Xjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:39:53 -0500
Date: Mon, 29 Nov 2004 00:39:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Message-ID: <20041128233934.GA2856@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296414.5805.286.camel@desktop.cunninghams> <20041124132949.GB13145@infradead.org> <20041125192834.GB1302@elf.ucw.cz> <1101680341.4343.291.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101680341.4343.291.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Here we add simple hooks so that the user can interact with suspend
> > > > while it is running. (Hmm. The serial console condition could be
> > > > simplified :>). The hooks allow you to do such things as:
> 
> > > > - change the amount of detail of debugging info shown
> > 
> > Use sysrq-X as you do during runtime.
> 
> No, I don't do this anymore. When I did, I had problems post-resume with
> the keyboard handler sometimes thinking SysRq was still pressed.

Fix keyboard handler, then... It probably happens with other keys
beside SysRq, right?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
