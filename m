Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFBPr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFBPr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFBPr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:47:59 -0400
Received: from mail.ccur.com ([208.248.32.212]:48177 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261167AbVFBPr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:47:58 -0400
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
From: Steve Rotolo <steve.rotolo@ccur.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, bugsy@ccur.com
In-Reply-To: <200506022334.31430.kernel@kolivas.org>
References: <1117561608.1439.168.camel@whiz>
	 <200506020925.26320.kernel@kolivas.org> <1117719021.1436.56.camel@whiz>
	 <200506022334.31430.kernel@kolivas.org>
Content-Type: text/plain
Organization: Concurrent Computer Corporation
Message-Id: <1117727326.1436.73.camel@whiz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 02 Jun 2005 11:48:46 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2005 15:47:53.0109 (UTC) FILETIME=[6FF03C50:01C5678A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 09:34, Con Kolivas wrote:

> Funny you should mention this. Check the latest -mm code and you'll see Andrew 
> has merged my smp nice code which takes into account "nice" values and alters 
> balancing according to nice values and heavily biases them when real time 
> tasks are running. So you are correct, and it is a problem common to any 
> per-cpu runqueue designed scheduler (which interestingly there is evidence 
> that windows went to in about 2003 because it exhibited this very problem). 
> However my code should make this behave better now.
> 

Glad to hear this is in --mm!  And BTW, your patch works great with my
HT test case.  Thanks -- good job.

-- 
Steve

