Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWFSEhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWFSEhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWFSEhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:37:16 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:39407 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S1750826AbWFSEhP (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:37:15 -0400
Message-Id: <5.1.1.5.2.20060619142049.049e1ee0@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 19 Jun 2006 14:37:12 +1000
To: Shailabh Nagar <nagar@watson.ibm.com>
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: New Metrics to measure Load average
Cc: linux-Kernel@vger.kernel.org
In-Reply-To: <44962320.8040201@watson.ibm.com>
References: <5.1.1.5.2.20060619124345.0335fda0@brain.sedal.usyd.edu.au>
 <4492D948.8090300@in.ibm.com>
 <5.1.1.5.2.20060616110033.04483890@brain.sedal.usyd.edu.au>
 <4492D948.8090300@in.ibm.com>
 <5.1.1.5.2.20060619124345.0335fda0@brain.sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nagar,

Thanks for your response and time.

Yes a good question.

(a) The short tasks to measure the response time itself after applying the 
division of load and before.

(b) The long tasks means HPC tasks to measure the load signal after 
applying the division of load and before.

I have run it for 600s, 1000s, and 1500s.

The both these tests were successful.

What I want to document is some standard tests just like using lmbench and 
re-aim-7.

I will go through your web site as well

Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia




At 12:08 AM 6/19/2006 -0400, you wrote:
>sena seneviratne wrote:
>
>>In fact my question in the post was about performance testing after the 
>>changes being done.
>>
>>--2) Now about the tests
>>--As I have documented all this yet need to perform some standard tests 
>>for the sake of completion.
>>--What tests should I carry out to prove that the system is still intact?
>
>
>>--Please tell me whether the below is correct?
>>
>>--(a) As suggested by the http://kernel-perf.sourceforge.net/ the lmbench 
>>and re-aim-7 test packages can be used to test the ----performance of the 
>>kernel before making changes and after. (Not done as yet)
>To measure impact of patches for a kernel tree, Contest (available from 
>http://freshmeat.net/projects/contest/)
>is a good start. lmbench is also useful.
>
>>--(-b) Further tests have been carried out to check the response time of 
>>short tasks before making changes and after making --changes. The results 
>>indicated that there was no difference in the response time after 
>>introducing the changes to the kernel (done)
>>
>>---(c) Thereafter the tests have been carried out to check the runtime of 
>>long tasks before and after making changes. The results of the tests 
>>revealed that there is no change in reported runtime in both occasions.(done)
>Why is there a distinction between short and long running tasks when 
>overall performance overhead
>of the kernel needs to be verified ?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

