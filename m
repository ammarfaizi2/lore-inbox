Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWBWBHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWBWBHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWBWBHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:07:08 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22188 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030353AbWBWBHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:07:06 -0500
Message-ID: <43FD0AB1.8070106@zytor.com>
Date: Wed, 22 Feb 2006 17:06:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bcrl@kvack.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
References: <20060223001411.GA20487@kvack.org>	<20060222.164347.12864037.davem@davemloft.net>	<43FD08D8.70300@zytor.com> <20060222.170344.84235860.davem@davemloft.net>
In-Reply-To: <20060222.170344.84235860.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 
>>At this point, I'm more than willing to treat SPARC as a special case, 
>>but I really want to know what the rules actually _ARE_ as opposed to 
>>what they are supposed to be (which they clearly are not.)
> 
> I have to admit I'm totally stumped...
> 
> Why are you invoking mmap2() instead of mmap64() btw?

Most 32-bit architectures don't have sys_mmap64; in fact the only one 
that seem to is parisc, for HPUX compatibility.  I'm trying to keep the 
differences between architectures as small as possible.

	-hpa
