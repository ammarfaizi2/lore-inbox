Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUITFJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUITFJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 01:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUITFJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 01:09:03 -0400
Received: from web70208.mail.krs.yahoo.com ([202.165.108.67]:5560 "HELO
	web70208.mail.krs.yahoo.com") by vger.kernel.org with SMTP
	id S266115AbUITFI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 01:08:58 -0400
Message-ID: <20040920050855.45521.qmail@web70208.mail.krs.yahoo.com>
Date: Mon, 20 Sep 2004 14:08:55 +0900 (JST)
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
Huh..


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
