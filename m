Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUJIJ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUJIJ1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUJIJ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 05:27:38 -0400
Received: from web70210.mail.krs.yahoo.com ([202.165.108.69]:30109 "HELO
	web70210.mail.krs.yahoo.com") by vger.kernel.org with SMTP
	id S266615AbUJIJ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 05:27:37 -0400
Message-ID: <20041009092735.62787.qmail@web70210.mail.krs.yahoo.com>
Date: Sat, 9 Oct 2004 18:27:35 +0900 (JST)
From: Jeon <jmj119kr@yahoo.co.kr>
Subject: please, help me!!(gettimeofday() problem in kernel mode)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to modify kernel2-4-18 for checkpointing and
recovering(s.t. fault tolerance)
When I measure using time for checkpointing and
recovering in kernel mode, I found there is some
problem with measuring accurate time using
gettimeofday().
My watch said ten seconds is past, but using
gettimeofday() said only 1 second!!
Is there other method or function for figuring out
using time in kernel mode?

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
