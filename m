Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVCWHIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVCWHIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVCWHIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:08:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51112 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262829AbVCWHIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:08:39 -0500
Date: Wed, 23 Mar 2005 08:07:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Arun Srinivas <getarunsri@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related
 questions?
In-Reply-To: <4240A744.1000306@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0503230806460.21578@yvahk01.tjqt.qr>
References: <BAY10-F42C3843D362DEB897FCABBD94E0@phx.gbl> <4240A744.1000306@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is pretty tricky. Basically processes on different CPUs are
> scheduled completely independently of one another. The only time
> when they may get moved from one CPU to another is with
> load_balance, load_balance_newidle, active_load_balance,
> try_to_wake_up, sched_exec, wake_up_new_task.

And of course, migrate_task() if I'm not mistaken. :)



Jan Engelhardt
-- 
