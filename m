Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbVJEW6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbVJEW6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbVJEW6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:58:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27305 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030417AbVJEW6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:58:05 -0400
Date: Thu, 6 Oct 2005 00:57:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051005225727.GE22781@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz> <434443D9.3010501@colitti.com> <20051005224418.GA22781@elf.ucw.cz> <4344599B.7060308@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4344599B.7060308@colitti.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 06-10-05 00:54:19, Lorenzo Colitti wrote:
> Pavel Machek wrote:
> >>- It was dog slow because it doesn't use compression
> >>- Even though it's dog slow, it doesn't save all RAM
> >>  - Therefore the machine is dog slow after resume
> >>- It doesn't have a decent UI
> >>- There is no way to abort suspend once it's started. [...]
> >
> >With uswsusp (aka swsusp3), you can do all this in userland. Stop
> >whining, start hacking... Code is at kernel.org/git/.../linux-sw3.
> 
> But that was exactly my point: there's no need to hack!
> 
> The code is there. It's well tested, fast, stable, and does what users 
> need. It's called suspend2. Why work on yet another implementation 
> instead of just merging that?

Most of that code does not belong it kernel. It can't be "just
merged". If we had nice "vi" implementation in kernel, we'd have to
drop it and start again in userland. This is similar.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
