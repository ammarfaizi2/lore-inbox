Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268317AbTBYU4g>; Tue, 25 Feb 2003 15:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268319AbTBYU4f>; Tue, 25 Feb 2003 15:56:35 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:37638 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S268317AbTBYU4f>; Tue, 25 Feb 2003 15:56:35 -0500
Message-ID: <3E5BDADC.2040606@didntduck.org>
Date: Tue, 25 Feb 2003 16:06:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hayes <mike@aiinc.ca>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Spelling fixes for 2.5.63 - won't
References: <200302252031.h1PKVI824928@aiinc.aiinc.ca>
In-Reply-To: <200302252031.h1PKVI824928@aiinc.aiinc.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hayes wrote:
> This fixes:
>     wont -> won't (25 occurrences)
> 
> diff -ur a/arch/alpha/lib/ev6-stxcpy.S b/arch/alpha/lib/ev6-stxcpy.S
> --- a/arch/alpha/lib/ev6-stxcpy.S	Mon Feb 24 11:05:04 2003
> +++ b/arch/alpha/lib/ev6-stxcpy.S	Tue Feb 25 10:07:59 2003
> @@ -128,7 +128,7 @@
>  	ldq_u	t1, 0(a1)		# L : load first src word
>  	and	a0, 7, t0		# E : take care not to load a word ...
>  	addq	a1, 8, a1		# E :
> -	beq	t0, stxcpy_aligned	# U : ... if we wont need it (stall)
> +	beq	t0, stxcpy_aligned	# U : ... if we won't need it (stall)
>  
>  	ldq_u	t0, 0(a0)	# L :
>  	br	stxcpy_aligned	# L0 : Latency=3

Be careful with apostrophes in asm files.  Some assemblers will barf on 
them when not in C style comments.

--
				Brian Gerst


