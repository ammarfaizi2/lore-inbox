Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTEAQk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTEAQk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:40:27 -0400
Received: from mailscan.binghamton.edu ([128.226.8.20]:24784 "HELO
	mailscan.binghamton.edu") by vger.kernel.org with SMTP
	id S261151AbTEAQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:40:26 -0400
Date: Thu, 1 May 2003 12:52:43 -0400 (EDT)
From: Zhihui Zhang <bf20761@binghamton.edu>
X-X-Sender: bf20761@bingsun2.cc.binghamton.edu
To: linux-kernel@vger.kernel.org
Subject: Re-drive buffer head more than once
Message-ID: <Pine.SOL.L4.44.0305011246180.28401-100000@bingsun2.cc.binghamton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it legal to call general_make_request() more than once on the same bh?
What will happen if a previous request is still in the queue, or just
initiated but not finished yet?  If I call general_make_request() on the
same buffer 10 times, does it mean the same buffer will *always* be
written 10 times on the disk?

Thanks for any enlightment!

-Zhihui


