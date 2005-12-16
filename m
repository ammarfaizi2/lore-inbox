Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVLPNvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVLPNvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVLPNvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:51:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50987
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932260AbVLPNvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:51:50 -0500
Date: Fri, 16 Dec 2005 14:51:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-ID: <20051216135147.GV5270@opteron.random>
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213211441.GH3092@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a minor buglet in the previous patch an update is here:

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.15-rc5/seqschedlock-2
