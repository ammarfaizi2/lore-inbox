Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131595AbRDCKj3>; Tue, 3 Apr 2001 06:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRDCKjT>; Tue, 3 Apr 2001 06:39:19 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:1251 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S131564AbRDCKjB>;
	Tue, 3 Apr 2001 06:39:01 -0400
From: James Stevenson <mistral@stev.org>
Date: Tue, 3 Apr 2001 11:43:48 GMT
Message-Id: <200104031143.LAA20434@linux.home>
To: ashley@alumni.caltech.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.15 kernel bug report
In-Reply-To: <200104030853.BAA00238@aa.home.org>
In-Reply-To: <200104030853.BAA00238@aa.home.org>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi

this was a bug in 2.2.15 you could do
while(1) { connect() }
and it would crash the kernel it was fixed by 2.2.16



In local.linux-kernel-list, you wrote:
>I am enclosing a section of code that crashes the 2.2.15 kernel
>repeatedly. My system is a 266 Intel P2 with 128Mb ram. The
>crash is caused by the connect statement. It does not crash
>if the socket is in BLOCKING mode. My distribution is Slack 7.0
>if that matters.
>


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
 11:40am  up 7 days, 19:35,  5 users,  load average: 2.33, 2.54, 2.58
