Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUH2OrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUH2OrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUH2OrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:47:13 -0400
Received: from lamity.org ([212.13.197.69]:2200 "HELO lamity.org")
	by vger.kernel.org with SMTP id S267976AbUH2Onl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:43:41 -0400
Date: Sun, 29 Aug 2004 15:43:38 +0100
From: "Simon Brackenboro'" <sb-kernel@zymic.org>
To: linux-kernel@vger.kernel.org
Subject: setitimer and timeval truncation
Message-ID: <20040829144338.GA14679@lamity.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email relates to a discussion on prjware@multivac.cwru.edu

You can receive a digest of the thread by sending a email to 
prjware-get.560_569@multivac.cwru.edu

I would expect setitimer to work over the range of time allowed by 
struct timeval.

This is not always the case as as timeval is truncated 
in timeval_to_jiffies to MAX_SEC_IN_JIFFIES (~25 days in my case).

Is this right ?

--
sb

