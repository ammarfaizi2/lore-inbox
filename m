Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVC2D2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVC2D2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVC2D2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:28:44 -0500
Received: from bay10-f47.bay10.hotmail.com ([64.4.37.47]:18790 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262168AbVC2D2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:28:42 -0500
Message-ID: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl>
X-Originating-IP: [68.62.238.188]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <42411CAC.5000808@yahoo.com.au>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: sched_setscheduler() and usage issues ....please help
Date: Tue, 29 Mar 2005 08:58:41 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 29 Mar 2005 03:28:42.0084 (UTC) FILETIME=[67D12240:01C5340F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to set the SCHED_FIFO  policy for my process.I am using 
sched_setscheduler() function to do this.

I am following the correct syntax and running it as root process.I am using 
the given syntax i.e.,
int sched_setscheduler(pid_t pid, int policy, const struct sched_param *p);
(SCHED_FIFO for the policy and priority in the range of 1 to 99 for p).

But the function returns with an value of -1. I am trying to call this 
function from the user-space.

1) Is this usage correct?
2)How do I read the error code (i.e., text description of what kiind of 
error occurred like for eg., ESRCH,EPERM,EINVAL).

Please help.

thanks
Arun

_________________________________________________________________
Don't know where to look for your life partner? 
http://www.bharatmatrimony.com/cgi-bin/bmclicks1.cgi?74 Trust 
BharatMatrimony.com

