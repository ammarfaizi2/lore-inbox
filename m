Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVCVW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVCVW0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCVWKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:10:46 -0500
Received: from bay10-f42.bay10.hotmail.com ([64.4.37.42]:51888 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262069AbVCVWJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:09:11 -0500
Message-ID: <BAY10-F42C3843D362DEB897FCABBD94E0@phx.gbl>
X-Originating-IP: [68.62.238.188]
X-Originating-Email: [getarunsri@hotmail.com]
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: help needed pls. scheduler(kernel 2.6) + hyperthreaded related questions?
Date: Wed, 23 Mar 2005 03:39:09 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Mar 2005 22:09:09.0873 (UTC) FILETIME=[C5CF6610:01C52F2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pls. help me.  I went through the sched.c for kernel 2.6 and saw that it 
supports
hyperthreading.I would be glad if someone could answer this question....(if
am not wrong a HT processor has 2 architectural states and one execution
unit...i.e., two pipeline streams)

1)when there are 2 processes a parent and child(created by fork()) do they
get scheduled @ the same time...ie., when the parent process is put into one
pipeline, do the child also gets scheduled the same time?

2) what abt in the case of threads(I read tht as opposed to kernel2.4,where
threads are treated as processes) ..kernel 2.6 treats threads as threads.
So, when two paired threads get into execution are they always scheduled at
the same time?

Also, it would be helpful if someone could suggest which part of sched.c
shud i look into to find out how threads are scheduled for a normal
processor and for a hyperthreaded processor

Pls. CC your replies to this email address getarunsri@hotmail.com

Thanks
Arun

_________________________________________________________________
Don't know where to look for your life partner? 
http://www.bharatmatrimony.com/cgi-bin/bmclicks1.cgi?74 Trust 
BharatMatrimony.com

