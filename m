Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWATQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWATQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWATQe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:34:57 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:11930 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751067AbWATQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:34:56 -0500
Date: Fri, 20 Jan 2006 17:35:51 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Michael Loftis <mloftis@wgops.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120163551.GC5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc1-marc-g18a41440-dirty
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Loftis <mloftis@wgops.com> [2006-01-20 09:07:16 -0700]:

> 
> 
> --On January 20, 2006 4:59:19 PM +0100 Marc Koschewski 
> <marc@osknowledge.org> wrote:
> 
> >For my daily work I use the -git kernels on my production machines. And I
> >didn't have probs for a long time due to stuff being tested in -mm. -mm
> >is mostly broken for me (psmouse, now reiserfs, ...) but I tend to say
> >that 2.6 is rock-stable.
> >
> >When it comes to API stability people are encouraged to stay up-to-date
> >when when developing stuff out of the kernel tree, ain't they? A more
> >convenient way would be to create a new in-kernel-tree wrapper module
> >that wraps some functions no longer available anymore and which are
> >possible to be wrapped in the meaning of all needed data is provided to
> >the 'old' method and can be easyily wrapped into the new function.
> >
> >It could a Kconfig option so that the 'wrapper module' is only activated
> >on demand. Thus, having the option to port driver directly to the new API
> >or just silenty use the 'wrapper module' to translate the call while
> >being noisy at compile time.
> >
> >You're free to write the module... ;)
> 
> I know this, but the in-kernel stuff is far less painful than when all this 
> stuff bleeds to userland.  Besides, can you imagine such a beast of a 
> module? :D  I mean yeouch, the maintenance.  And it'd encourage the sort of 
> thing we as kernel developers in general want to discourage, which is the 
> use of deprecated APIs.
> 
> Lots of things still out there depend on devfs.  So now if I want to 
> develop my kmod on recent kernels I have to be in the business of 
> maintaining a lot more userland stuff, like mkinitrd, installers, etc. that 
> have come to rely on devfs.

Moreover, as far as I remember... my devfsd -> udev transsition went as smooth
as a reboot.

Marc
