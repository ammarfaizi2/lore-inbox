Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVKUOUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVKUOUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKUOUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:20:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932306AbVKUOUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:20:07 -0500
Date: Mon, 21 Nov 2005 15:19:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051121141954.GB1655@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051120214832.GC28918@redhat.com> <20051120220904.GB24132@elf.ucw.cz> <200511211247.45558.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511211247.45558.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > With what we have in-kernel, and a restricted /dev/mem, achieving the
> > > attack you mention is a lot less feasible, as the attacker has no access
> > > to the memory being written out to the suspend partition, even as root.
> > > Even if they did, people tend to notice boxes shutting down pretty quickly
> > > making this a not-very-stealthy attack.
> > 
> > Can I read somewhere about security model you are using? Would it be
> > enough to restrict /dev/[k]mem to those people that have right to
> > update kernel anyway? Or your approach is "noone, absolutely noone has
> > right to modify running kernel"? [Do you still use loadable modules?]
> 
> The problem is that, whatever the security model, if you have access to the
> kernel memory (eg. via /dev/kmem), you can modify the security rules
> themselves, so this should better be avoided.

Well, under current linux security model, root has all permissions,
including inserting modifying running kernel, touching hardware
directly, and installing rootkits. Fedora may be trying to change
that... but if so, I'd like to know what they are planning.
								Pavel
-- 
Thanks, Sharp!
