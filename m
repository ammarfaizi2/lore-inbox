Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVCHGWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVCHGWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCHGU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:20:26 -0500
Received: from waste.org ([216.27.176.166]:30891 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261703AbVCHGTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:19:14 -0500
Date: Mon, 7 Mar 2005 22:18:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308061836.GL3120@waste.org>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <422D3AB2.9020409@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422D3AB2.9020409@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 04:40:02PM +1100, Peter Williams wrote:
> The granting of the ability to switch to and from RT mode should require 
> a means to specify which users it applies to and also which programs it 
> applies to.  The RT rlimits mechanism doesn't meet these criteria.

a) rlimits are per-process
b) rlimits are typically administered per-user
c) any user can trivially gain any privilege of any process they own
so in some sense per-process limits are meaningless

So rlimits are in fact as granular as can be, both in theory and in
practice.

-- 
Mathematics is the supreme nostalgia of our time.
