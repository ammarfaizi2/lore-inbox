Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUIQBgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUIQBgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUIQBgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:36:11 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:3488 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S268483AbUIQBgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:36:07 -0400
Message-ID: <414A3F87.5020009@zytor.com>
Date: Thu, 16 Sep 2004 18:36:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: tharbaugh@lnxi.com, klibc@zytor.com, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [klibc] Re: [PATCH] gen_init_cpio uses external file list
References: <1095372672.19900.72.camel@tubarao> <414A1C92.3070205@pobox.com>	<1095375235.19900.82.camel@tubarao> <414A2CFB.5000900@pobox.com>
In-Reply-To: <414A2CFB.5000900@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Thayne Harbaugh wrote:
> 
>> On Thu, 2004-09-16 at 19:06 -0400, Jeff Garzik wrote:
>>
>>> Seems OK to me...
>>>
>>>     Jeff, the original gen_init_cpio author
>>
>> There's been some minor discussion about the use of _GNU_SOURCE (needed
>> for getline()).  Comments?  I can rework the getline() if anyone can
>> make a case - otherwise I'm a bit lazy.
> 
> I am a bit leery of _GNU_SOURCE but whatever :)
> 

_GNU_SOURCE just means enable all features.  Perhaps it should be 
something more restrictive, like _XOPEN_SOURCE or _POSIX_SOURCE; both of 
those need to be set to specific values.

	-hpa
