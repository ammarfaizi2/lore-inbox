Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWBTUPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWBTUPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWBTUPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:15:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22497 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161124AbWBTUPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:15:16 -0500
Date: Mon, 20 Feb 2006 20:15:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-ID: <20060220201506.GU27946@ftp.linux.org.uk>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9B8A9.4000506@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9B8A9.4000506@reub.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It really would be more useful to pick individual branches
	fixes.b8
	m32r.b0
	m68k.b8
	xfs.b8
	uml.b1
	net.b6
	frv.b8
	misc.b8
	upf.b5
	volatile.b0
	endian.b8
	net-endian.b3
are relevant;
	infrastructure.b0
	not-for-merge.b1
are not.  The latter is obvious, the former is infrastructure needed to
support cross-build setup.

