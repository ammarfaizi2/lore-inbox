Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbSLTAIL>; Thu, 19 Dec 2002 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbSLTAIL>; Thu, 19 Dec 2002 19:08:11 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49938
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267677AbSLTAIK>; Thu, 19 Dec 2002 19:08:10 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200212201104.28863.conman@kolivas.net>
References: <200212200850.32886.conman@kolivas.net>
	 <200212201042.48161.conman@kolivas.net> <1040341995.2521.81.camel@phantasy>
	 <200212201104.28863.conman@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1040343375.2519.87.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 19:16:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 19:04, Con Kolivas wrote:

> Thanks. That looks fair enough. My only concern is that io_load performance is 
> worse with lower prio_bonus_ratio settings and io loads are the most felt.
> 
> I was thinking of changing what it varied. I was going to leave the timeslice 
> fixed and use it to change the prio_bonus_ratio under load. Although that 
> kind of defeats the purpose of having it in the first place since it is 
> supposed to decide what is interactive under load?

Yep.

You want to find good defaults that just work.

	Robert Love

