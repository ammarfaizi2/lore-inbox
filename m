Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWD1NJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWD1NJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 09:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWD1NJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 09:09:57 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:42918 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030382AbWD1NJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 09:09:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
Date: Fri, 28 Apr 2006 23:09:31 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <200604282011.36917.kernel@kolivas.org> <44520581.3090404@jp.fujitsu.com>
In-Reply-To: <44520581.3090404@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604282309.32320.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 22:07, MAEDA Naoaki wrote:
> Con Kolivas wrote:
> > I agree with Mike here. It's either global resource management or it
> > isn't. If one user is using all interactive tasks and the other user none
> > it's unfair resource management.
>
> My intention was not to hurt interactive task's response, but it seems
> that just ignoring interactive tasks is not good. I'll consider
> regulating interactive tasks also.

I appreciate the gesture of concern over interactive tasks :-) Unfortunately 
it doesn't change the fact that interactive tasks can also consume large 
proportions of the resources, and that any interactivity estimator will get 
it wrong on occasion and flag a non interactive task as interactive.

-- 
-ck
