Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVFNIqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFNIqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 04:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFNIqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 04:46:34 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:13456 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261283AbVFNIq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 04:46:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OG8IIIFqAIimQLSQgFH2lJJcBPoLtQjADOV1OsLWs1sGrUkFWrfI72fIDslCGzBRgq2myTG3l574fCAJribGWEqM1jcZp6t7yvwCFf0vD94y4KKiTQwYuGVcXK+ELw9KwOIWeSieJCUQ4bC1F6gFb3SHOFFW1njZEfYMHMh09/A=
Message-ID: <8631edda05061401463205d2fc@mail.gmail.com>
Date: Tue, 14 Jun 2005 10:46:28 +0200
From: Vincent Kergonna <kergonna.v@gmail.com>
Reply-To: Vincent Kergonna <kergonna.v@gmail.com>
To: yang.yi@bmrtech.com
Subject: Re: 2.6 kernel series have noticeable performance regression
Cc: LKML <linux-kernel@vger.kernel.org>,
       China Performance Team <china-perf@mvista.com>
In-Reply-To: <1118733263.10339.1553.camel@montavista2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1118733263.10339.1553.camel@montavista2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can we have the program/script you used to make your measures ?

Thanks.


On 6/14/05, yangyi <yang.yi@bmrtech.com> wrote:
> Hi, All
> 
> I did a performance regression test for all the 2.6 kernel series on two
> x86 platforms in last two weeks and found that some version kernels do
> have noticeable performance regression, some performance indices have
> about 20 to 30 percent regression,
>  even several indices have over 30 percent fall.
> 
> For example, on Toshiba tecra8000 laptop: for 4-bytes packet, network
> throughput of 2.6.11 is just about 57.5 percent of 2.6.0, for pipe
> bandwidth, the value of 2.6.11 is just about 68 percent of that value of
> 2.6.0, for mmap latency, the value of 2.6.11 is about 1.8 times as long
> as 2.6.0.
> 
> On supermicro-6012-p6, for 64-bytes small packet, network throughput of
> 2.6.11 is about 66.72 percent of 2.6.0, for 0K-size 2 processes context
> switch time, 2.6.11 is 31.8 percent bigger than 2.6.0, for pipe latency,
> 2.6.10 is 35.85 percent bigger than 2.6.3.
> 
> So, I think that it is very very necessary to find the problems and fix
> them ASAP.
> 
> The following articles give out all the test results, the article "2.6
> kernel series have noticeable performance regression, part 1" gives out
> the test results on SuperMicro-6012-p6, the article "2.6 kernel series
> have noticeable performance regression, part 2" gives out the test
> results on Toshiba tecra8000 laptop.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
