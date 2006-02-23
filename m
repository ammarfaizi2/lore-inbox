Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWBWRn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWBWRn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBWRn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:43:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:31198 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932354AbWBWRn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:43:58 -0500
Message-ID: <43FDF457.50502@zytor.com>
Date: Thu, 23 Feb 2006 09:43:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Paul Mackerras <paulus@samba.org>, klibc@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com> <17405.9318.991684.872546@cargo.ozlabs.ibm.com> <43FD2D96.7030600@zytor.com> <20060223173216.GA20322@linux-mips.org>
In-Reply-To: <20060223173216.GA20322@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> 
> A variable which happens to be fixed to 12 in practice.  As explained by
> Ben the API is only relevant to 32-bit kernels and afaik PAGE_SHIFT
> other than 12 has only been successfully been tested on 64-bit kernels.
> 

No, that's not correct.  This API is relevant to 32-bit *USERSPACE*.  If 
you support 32-bit userspace on a 64-bit kernel, it applies to 64-bit 
kernels, too.

	-hpa
