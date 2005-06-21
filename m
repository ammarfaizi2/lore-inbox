Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVFUN4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVFUN4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFUNz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:55:58 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24079 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261326AbVFUNxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:53:51 -0400
Date: Tue, 21 Jun 2005 14:53:49 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Domen Puncer <domen@coderock.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [patch 04/12] block/xd: replace schedule_timeout() with msleep()
In-Reply-To: <20050621132100.GL3906@nd47.coderock.org>
Message-ID: <Pine.LNX.4.61L.0506211451180.9446@blysk.ds.pg.gda.pl>
References: <20050620215133.675387000@nd47.coderock.org>
 <Pine.LNX.4.61L.0506211233490.9446@blysk.ds.pg.gda.pl>
 <20050621132100.GL3906@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Domen Puncer wrote:

> mdelay - busy loop
> msleep - schedule

 Right -- that's my mistake.  But what's the point of the change in the 
first place anyway?  The original code is correct.

  Maciej
