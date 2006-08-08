Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWHHO72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWHHO72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWHHO72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:59:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964904AbWHHO71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:59:27 -0400
Date: Tue, 8 Aug 2006 15:59:24 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] BUG/OOPS fix
Message-ID: <20060808145924.GX18633@agk.surrey.redhat.com>
Mail-Followup-To: device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20060808113227.GA26434@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060808113227.GA26434@rere.qmqm.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 01:32:27PM +0200, Michał Mirosław wrote:
> BUG shows up on error path in multipath_ctr() when parse_priority_group() fails
> after returning at least once without error. The fix is to initialize m->ti
> early - just after alloc()ing it.
 
Yes.

Alasdair
-- 
agk@redhat.com
