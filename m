Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUA0Skc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUA0Skc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:40:32 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:45217 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S263832AbUA0Ska
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:40:30 -0500
Date: Tue, 27 Jan 2004 11:40:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BitKeeper repo for KGDB
Message-ID: <20040127184029.GI32525@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.  Since I've been talking with George off-list about
trying to merge the various versions of KGDB around, and I just read the
thread between Andy and Jim about conflicting on KGDB work, I've put up
a BitKeeper repository[1] to try and coordinate things.

What's in there right now is Amit's kgdb 2.1.0, without the ethernet
patch.   There's also all of the changes for PPC and for generic stuffs
that I've been doing of late.

What I'll be doing shortly (this afternoon even) is to change from a
struct of function pointers, for the arch specific functions, into a set
of provided, weak, variants and then allow arches to override as needed.

What I'd like is for someone to move the ethernet bits from the -mm tree
into here, and for people to merge the fixes / enhancements that're in
their per-arch stubs in the -mm tree into the split design that Amit's
version has.

Comments? Screams? Patches? :)

[1]: If anyone here won't / can't use BitKeeper, I'll happily move over
to a repo someone else sets up in something else.
-- 
Tom Rini
http://gate.crashing.org/~trini/
