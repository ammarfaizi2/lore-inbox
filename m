Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267398AbUG2BYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267398AbUG2BYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUG2BYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:24:09 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:18152 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267398AbUG2BYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:24:02 -0400
To: Ben Hoskings <ben@jeeves.gotdns.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>, corbet@lwn.net
Subject: Re: New dev model (was [PATCH] delete devfs)
References: <40FEEEBC.7080104@quark.didntduck.org>
	<20040722193337.GE19329@fs.tum.de>
	<20040722160112.177fc07f.akpm@osdl.org>
	<200407261138.55020.ben@jeeves.gotdns.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 28 Jul 2004 23:22:15 +0200
In-Reply-To: <200407261138.55020.ben@jeeves.gotdns.org> (Ben Hoskings's
 message of "Mon, 26 Jul 2004 11:38:55 +1000")
Message-ID: <m3hdrrj08o.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Hoskings <ben@jeeves.gotdns.org> writes:

> I think the idea of forking off certain releases in the 2.6.x.0 form, to only 
> recieve bugfixes and security updates, is a very good idea. A couple of 
> points against it were raised above, but I think if it were approached the 
> right way, they wouldn't be issues.

I think so.

I assume the numbering will stay the same, i.e. 
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 8
EXTRAVERSION =-rc2

will eventually become
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 8
EXTRAVERSION =

and then possibly

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 8
EXTRAVERSION =.1 (or -pl1 etc.)

so it won't require changing scripts.

> IMO the process wouldn't mirror the old 2.x / 2.y model because it is much 
> more fine-grained. With the old model, changes have to be backported to a 
> kernel that is significantly older, and which potentially has seen 
> fundamental changes in the releases between (i mean between 2.x -> 2.y).

I think so. The scheme is somehow similar to -AC (Alan Cox') tree -
and we all know that it (the process etc) was working very well.
-- 
Krzysztof Halasa
