Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVCWINT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVCWINT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVCWINT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:13:19 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:37342 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262850AbVCWINS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:13:18 -0500
Date: Wed, 23 Mar 2005 00:13:16 -0800 (PST)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@kaki.stanford.edu
To: linux-kernel@vger.kernel.org
Subject: memory leak in net/sched/ipt.c?
Message-ID: <Pine.LNX.4.61.0503230011090.4207@kaki.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the memory block allocated on line 315 leaked every time tcp_ipt_dump 
is called?
