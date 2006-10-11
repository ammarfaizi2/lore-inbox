Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161538AbWJKV7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161538AbWJKV7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbWJKV7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:59:04 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21941 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161538AbWJKV7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:59:01 -0400
Message-ID: <452D6921.5010300@us.ibm.com>
Date: Wed, 11 Oct 2006 14:58:57 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org> <452D4BF0.20209@google.com>
In-Reply-To: <452D4BF0.20209@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/ 
>>
>>
>>
>>
>>   
> fsx seems to fail now, across several different machines.
>
> http://test.kernel.org/functional/index.html
>
>
> and drill down under "regression" on the failing ones.
>
> eg, see end of
> http://test.kernel.org/abat/54516/debug/test.log.1 (i386)
> and
> http://test.kernel.org/abat/54503/debug/test.log.1 (x86_64)
>

I am seeing fsx failures on 1k/2k ext3 filesystems, but not on 4k.
Do you know the filesystem type & blocksize ?

Thanks,
Badari

