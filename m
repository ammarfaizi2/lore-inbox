Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTGKSJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbTGKSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:09:06 -0400
Received: from web10001.mail.yahoo.com ([216.136.130.37]:49065 "HELO
	web10001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264730AbTGKRzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:55:44 -0400
Message-ID: <20030711181025.14633.qmail@web10001.mail.yahoo.com>
Date: Fri, 11 Jul 2003 11:10:25 -0700 (PDT)
From: Keyser Soze <keyser_soze2u@yahoo.com>
Subject: RE: Geode GX1, video acceleration -> crash
To: linux-kernel@vger.kernel.org
Cc: ferenc@engard.hu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the real problem is, that I wanted to benchmark
> the system while the scrolling continues, and issued
> a dd if=/dev/mem of=/dev/null bs=1024 count=32768
> command. For the second go, the system freezed like
> a good refrigerator. No kernel panic, nothing, just
> freezed. 

Try turning off ide dma and see if that helps.  You
will lose very little by turning off udma on this
system and I'll bet you end up being more stable.


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
