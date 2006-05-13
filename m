Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWEMV0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWEMV0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 17:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWEMV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 17:26:18 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:45204 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932140AbWEMV0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 17:26:17 -0400
Date: Sat, 13 May 2006 23:26:00 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] unnecessary long index i in sched
In-Reply-To: <Pine.LNX.4.58.0605131311590.27751@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.61.0605132325070.11638@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0605131311590.27751@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Unless we expect to have more than 4294967295 CPUs, there's no reason to
>have 'i' as a long long here.
>
If declaring it as int, your number should read as 2147483647. :)


Jan Engelhardt
-- 
