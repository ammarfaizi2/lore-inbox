Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUCZUGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUCZUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:06:15 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37770 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261169AbUCZUGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:06:14 -0500
Message-ID: <40648D2D.2000201@nortelnetworks.com>
Date: Fri, 26 Mar 2004 15:06:05 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18-2.4.22 signal handling speed regression
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have an app that uses signals heavily (30K/sec at times).  When 
moving it from 2.4.18 to 2.4.22, we noticed a significant speed 
decrease, to the point where it is about 2.5 times slower on 2.4.22.

We're trying to figure out what is causing the problem, but I thought 
I'd see if anyone has any ideas off the top of their heads.

PowerPC hardware, 1 cpu, single-threaded app.

Thanks,

Chris
