Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVEXWax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVEXWax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEXW2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:28:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:11473 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261321AbVEXW1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:27:50 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: "Clifford T. Matthews" <ctm@ardi.com>, linux-kernel@vger.kernel.org
Cc: Cliff Matthews <ctm@ardi.com>
Subject: Re: surprisingly slow accept/connect cycle time
Date: Tue, 24 May 2005 22:27:41 +0000
Message-Id: <052420052227.599.4293AA5D00008DF100000257220075074400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that it takes ages to complete without the sched_yield. (2.6.11-gentoo). With sched_yield it's very fast.

Funny thing is that strace'ing the running process (without sched_yield) makes it run very fast. 

I tried to oprofile it but no kernel or process stats changed due to the process run. (It might be doing nothing at all..)

Parag


