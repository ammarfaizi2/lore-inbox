Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVB0P44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVB0P44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVB0P44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:56:56 -0500
Received: from ns.suse.de ([195.135.220.2]:18388 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261415AbVB0P4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:54 -0500
Message-Id: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 00/16] NFSACL protocol extension for NFSv3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an update of the whole NFSACL patchset. I think I have addressed
all issues brought up, except for these two:

 - Not sure what do do about the Solaris compatibility hack. It's
   ugly no matter how we hide it, so I'll probably keep it the way
   it is now,

 - Matt's heapsort is defective, so I'm not using it right now.

Regards,
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

