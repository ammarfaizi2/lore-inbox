Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTE0Fmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTE0Fmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:42:32 -0400
Received: from dp.samba.org ([66.70.73.150]:7345 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261759AbTE0Fmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:42:31 -0400
Date: Tue, 27 May 2003 15:55:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Quasi-deleted files
Message-ID: <20030527055557.GA17792@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

It seems there are a handful of zero-length but not deleted files in
the BK tree, but which are not present in the tarball releases and
also removed by make distclean.  These can cause irritating spurious
diffs - could you "bk rm" these from linux-2.5?  The files are:

	include/pcmcia/bus_ops.h
	include/pcmcia/driver_ops.h
	include/sound/pcm_sgbuf.h
	sound/core/pcm_sgbuf.c

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
