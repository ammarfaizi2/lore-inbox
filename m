Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbULZJRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbULZJRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 04:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbULZJRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 04:17:51 -0500
Received: from mail.linicks.net ([217.204.244.146]:48644 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261546AbULZJRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 04:17:40 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 typo in include/linux/netfilter.h
Date: Sun, 26 Dec 2004 09:17:38 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412260917.38717.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Breaks the build.

Line 161

/* Call setsockopt() */
int nf_setsockopt(struct sock *sk, int pf, int optval, char __user *opt,
                  int len(;  <-------

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
