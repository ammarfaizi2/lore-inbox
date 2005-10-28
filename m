Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVJ2AFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVJ2AFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVJ2AFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:05:49 -0400
Received: from [67.137.28.189] ([67.137.28.189]:55937 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1750877AbVJ2AFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:05:48 -0400
Message-ID: <4362A9A7.2090101@utah-nac.org>
Date: Fri, 28 Oct 2005 16:43:51 -0600
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com> <4362BA30.2020504@pobox.com>
In-Reply-To: <4362BA30.2020504@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Verified.  These numbers reflect my measurements as well.    I have not 
moved off 2.6.9 to newer kernels on shipping products due to these 
issues.   There are also serious stability issues as well, though 2.6.14 
seems a little better than than previous kernels.  

Jeff



Jeff Garzik wrote:

> Chen, Kenneth W wrote:
>
>> Kernel performance data for 2.6.14 (released yesterday) is updated at:
>> http://kernel-perf.sourceforge.net
>>
>> As expected, results are within run variation compares to 2.6.14-rc5.
>> No significant deviation found compare to 2.6.14-rc5
>
>
> Do I read this correctly:  according to your benchmarks, fileio-noop 
> and fileio-cfq are down some 20% or more, across all machine 
> configurations, since 2.6.9? In the 4P configuration, dbench-{noop,as} 
> both seem to have regressed as well.
>
>     Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

