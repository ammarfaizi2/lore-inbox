Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWIRLQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWIRLQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 07:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWIRLQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 07:16:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:16750 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932246AbWIRLQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 07:16:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OQ5L+GOaFpfgrtYQikGz+lNSPrlwJDcpidICr9YFBZCPkMLOTqJ7DRsU4wV6PVlGqkH0RvqdXDXsumRc4Ko/frqAWFtWHhsrBC0GnDTDCzM5JVbXXLJee+502PXGLaW8QpZ7fSUQtDcloHfUBf9LRGsoLrfNrfJpYKU2aJMJytY=
Message-ID: <450E802B.800@gmail.com>
Date: Mon, 18 Sep 2006 15:16:59 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] CPUFreq PowerOP integration, Centrino PM Core
 and OPs registration 2/3
References: <45096C1A.7010008@gmail.com> <20060918104624.GB4973@elf.ucw.cz>
In-Reply-To: <20060918104624.GB4973@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> +/* 
>> + * FIXME: very temporary implementation, just to prove the concept !! 
>> + */
>> +static int 
>> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
>> +		  int va_arg)
> 
> Ok, so can we get final implementation? Parsing strings in drivers is
> evil...
ok, i saw this your comment when you mentioned it for the first time and I 
explicitly put it in TODO letter sent along with the patchset.

Can you instead of such implementation details try to review and give us your 
comments if any on interfaces approach and namely on cpufreq/PowerOP integration 
at cpufreq_driver layer; comments _based_ on the code. The issue with string 
parsing does not affect cpufreq/PowerOP integration interfaces since currently I 
keep going with parameter names(strings) interface for PowerOP Core regardless 
of whether parsing will eventually occur - at PM Core or POwerOP Core.

	Eugeny
> 
> 									Pavel
> 

