Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUBQX6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBQX61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:58:27 -0500
Received: from 62-43-1-4.user.ono.com ([62.43.1.4]:27776 "EHLO
	mortadelo.pirispons.net") by vger.kernel.org with ESMTP
	id S266669AbUBQX6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:58:12 -0500
Date: Wed, 18 Feb 2004 00:58:10 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Bas Mevissen <ml@basmevissen.nl>, "Theodore Ts'o" <tytso@mit.edu>,
       Jan Dittmer <j.dittmer@portrix.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 on raid5 failure
Message-ID: <20040217235810.GA6582@mortadelo.pirispons.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Bas Mevissen <ml@basmevissen.nl>, Theodore Ts'o <tytso@mit.edu>,
	Jan Dittmer <j.dittmer@portrix.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl> <1075887812.2518.125.camel@laptop-linux> <4020D9A5.2040109@basmevissen.nl> <1075927775.2037.136.camel@laptop-linux> <20040217231429.GD666@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217231429.GD666@elf.ucw.cz>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2004 at 00:14, Pavel Machek wrote:

> > Not everything! I have my email client set up to highlight messages that
> > mention suspend or swsusp. :>
> 
> Clever ;-). [How does one do that in mutt?]

color index yellow black '(~b suspend | ~b swsusp)'

But if you use remote mailboxes (such as imap or pop) this sucks. So
it's better to put something like:


folder-hook . "uncolor index *"
folder-hook . "color index yellow black '(~b suspend | ~b swsusp)'"
folder-hook ^imaps?:// "uncolor index *"
folder-hook ^pops?://  "uncolor index *"


in your .muttrc to avoid downloading _all_ message bodies in the index
when reading imap(s) or pop(s) mailboxes.

-- 
Kiko
