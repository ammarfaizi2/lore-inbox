Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265167AbSJaD3K>; Wed, 30 Oct 2002 22:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265153AbSJaD2U>; Wed, 30 Oct 2002 22:28:20 -0500
Received: from dp.samba.org ([66.70.73.150]:29640 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265167AbSJaDZG>;
	Wed, 30 Oct 2002 22:25:06 -0500
To: hch@infradead.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, geert@linux-m68k.org,
       rmk@arm.linux.org.uk, peter@chubb.wattle.id.au, tytso@mit.edu
In-reply-to: <20021031032253.A20572@infradead.org> (message from Christoph
	Hellwig on Thu, 31 Oct 2002 03:22:53 +0000)
Subject: Re: What's left over.
Reply-To: tridge@samba.org
Message-Id: <20021031033132.4ED792C269@lists.samba.org>
Date: Wed, 30 Oct 2002 22:31:32 -0500 (EST)
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> XFS doesn't have ACLs either in plain 2.5.

The existing NAS boxes that use Linux and XFS tend to base their
kernels on the 2.4-xfs tree from cvs on sgi.com. It works well and the
SGI guys have been very good about fixing problems when they crop up.

I think that the biggest beneficiary of adding extended attributes and
ACLs into ext3 for 2.6 would be more casual users (home, small office
etc) as they will then be able to use ACLs in Samba without the pain
of switching to a different kernel.

Cheers, Tridge

--
http://samba.org/~tridge/
