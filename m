Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbTDMQ6K (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTDMQ6J (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 12:58:09 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:38869 "EHLO
	renegade") by vger.kernel.org with ESMTP id S263551AbTDMQ6I (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 12:58:08 -0400
Date: Sun, 13 Apr 2003 10:09:51 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: lk-changelog.pl 0.96
Message-ID: <20030413170951.GC21855@renegade>
References: <20030413104943.433A37EBE4@merlin.emma.line.org> <20030413144218.GB21855@renegade> <20030413162338.GC22268@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413162338.GC22268@merlin.emma.line.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 06:23:38PM +0200, Matthias Andree wrote:
> On Sun, 13 Apr 2003, Zack Brown wrote:
> 
> > On Sun, Apr 13, 2003 at 12:49:43PM +0200, Matthias Andree wrote:
> > > This is a semi-automatic announcement.
> > > 
> > > lk-changelog.pl aka. shortlog version 0.96 has been released.
> > 
> > I think these emails from Alan and Linus actually appear in changelogs.
> 
> They are caught by the recently added regexp parser and don't need to be
> listed explicitly. If you're running ./lk-changelog.pl --selftest, it'll
> print a list of addresses that are matched by a regexp (the printout
> actually suggests the opposite, but that's an implementation detail;
> these lookups are tuned for speed).

Too bad for me, I was hoping to use that data structure as a complete list
of email -> name translations for changelog entries. Maybe you could
include them anyway as commented out entries in the data structure? That
would give your script the added benefit of being harvestable for other
purposes, but wouldn't sacrifice the regex speed enhancements.

Not that it's not harvestable now, but folks wouldn't have to maintain
their own addenda.

Be well,
Zack

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zack Brown
