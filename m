Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVCVGU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVCVGU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVCVGQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:16:48 -0500
Received: from bay10-f5.bay10.hotmail.com ([64.4.37.5]:35156 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262272AbVCVGLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:11:01 -0500
Message-ID: <BAY10-F50065A16FC9296049E7D4D94E0@phx.gbl>
X-Originating-IP: [68.62.238.188]
X-Originating-Email: [getarunsri@hotmail.com]
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: scheduler(kernel 2.6) + hyperthreaded related questions?
Date: Tue, 22 Mar 2005 11:40:48 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Mar 2005 06:10:49.0209 (UTC) FILETIME=[E4BE5E90:01C52EA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went through the sched.c for kernel 2.6 and saw that it supports 
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
The MSN Survey! 
http://www.cross-tab.com/surveys/run/test.asp?sid=2026&respid=1 Help us help 
you better!

