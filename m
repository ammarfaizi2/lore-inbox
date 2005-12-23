Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030604AbVLWTE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030604AbVLWTE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVLWTE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 14:04:27 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:42708 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030604AbVLWTE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 14:04:26 -0500
Subject: Re: [PATCH] sched: Fix
	adverse	effects	of	NFS	client	on	interactive response
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1135330757.8167.44.camel@lade.trondhjem.org>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
	 <1135297525.3685.57.camel@lade.trondhjem.org>
	 <43AB69B8.4080707@bigpond.net.au>
	 <1135330757.8167.44.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 14:07:01 -0500
Message-Id: <1135364822.22177.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 10:39 +0100, Trond Myklebust wrote:
> No! This is not the same thing at all.
> 
> You are asking the coder to provide a policy judgement as to whether
> or
> not the users might care.
> 
> As far as I'm concerned, other users' MP3 player, X processes, and
> keyboard response times can rot in hell whenever I'm busy writing out
> data at full blast. I don't give a rats arse about user interactivity,
> because my priority is to see the batch jobs complete.
> 

By your logic it's also broken to use cond_resched() in filesystem code.

Lee

