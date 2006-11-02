Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWKBREk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWKBREk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWKBREk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:04:40 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:18560 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751093AbWKBREj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:04:39 -0500
Date: Thu, 2 Nov 2006 17:59:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Gruenbacher <agruen@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Gerard Neil <xyzzy@devferret.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix user.* xattr permission check for sticky dirs
In-Reply-To: <200611021724.02886.agruen@suse.de>
Message-ID: <Pine.LNX.4.61.0611021759390.24554@yvahk01.tjqt.qr>
References: <200611021724.02886.agruen@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The user.* extended attributes are only allowed on regular files and
>directories. Sticky directories further restrict write access to the
>owner and privileged users. (See the attr(5) man page for an
>explanation.)
>

Does this effect ACL handling for sticky dirs in any way?


	-`J'
-- 
