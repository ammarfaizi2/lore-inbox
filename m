Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUIXSjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUIXSjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUIXSjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:39:17 -0400
Received: from web70211.mail.krs.yahoo.com ([202.165.108.70]:22705 "HELO
	web70211.mail.krs.yahoo.com") by vger.kernel.org with SMTP
	id S269065AbUIXSjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:39:14 -0400
Message-ID: <20040924183912.66557.qmail@web70211.mail.krs.yahoo.com>
Date: Sat, 25 Sep 2004 03:39:12 +0900 (JST)
From: Jeon <jmj119kr@yahoo.co.kr>
Subject: gettimeofday() problem in kernel mode
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to modify kernel2-4-18 for checkpointing and
recovering(s.t. fault tolerance)
When I measure duration time for checkpointing and
recovering in kernel mode, I found there is some
problem with measuring accurate duration time using
gettimeofday().
My watch said ten seconds is past, but kernel said
only 1 second!!
Is there other method or function for figuring out
duration time in kernel mode?



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
