Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWFSEIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWFSEIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFSEIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:08:04 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:9647 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932098AbWFSEIB (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:08:01 -0400
Date: Mon, 19 Jun 2006 00:08:00 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: New Metrics to measure Load average
In-reply-to: <5.1.1.5.2.20060619124345.0335fda0@brain.sedal.usyd.edu.au>
To: sena seneviratne <auntvini@cel.usyd.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-Kernel@vger.kernel.org
Message-id: <44962320.8040201@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <4492D948.8090300@in.ibm.com>
 <5.1.1.5.2.20060616110033.04483890@brain.sedal.usyd.edu.au>
 <4492D948.8090300@in.ibm.com>
 <5.1.1.5.2.20060619124345.0335fda0@brain.sedal.usyd.edu.au>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sena seneviratne wrote:

> In fact my question in the post was about performance testing after 
> the changes being done.
>
> --2) Now about the tests
> --As I have documented all this yet need to perform some standard 
> tests for the sake of completion.
> --What tests should I carry out to prove that the system is still intact?


> --Please tell me whether the below is correct?
>
> --(a) As suggested by the http://kernel-perf.sourceforge.net/ the 
> lmbench and re-aim-7 test packages can be used to test the 
> ----performance of the kernel before making changes and after. (Not 
> done as yet)
>
To measure impact of patches for a kernel tree, Contest (available from 
http://freshmeat.net/projects/contest/)
is a good start. lmbench is also useful.

> --(-b) Further tests have been carried out to check the response time 
> of short tasks before making changes and after making --changes. The 
> results indicated that there was no difference in the response time 
> after introducing the changes to the kernel (done)
>
> ---(c) Thereafter the tests have been carried out to check the runtime 
> of long tasks before and after making changes. The results of the 
> tests revealed that there is no change in reported runtime in both 
> occasions.(done)
>
Why is there a distinction between short and long running tasks when 
overall performance overhead
of the kernel needs to be verified ?

