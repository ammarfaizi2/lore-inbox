Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUBYXjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUBYXgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:36:13 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:42252 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261669AbUBYXev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:34:51 -0500
Message-ID: <403D3379.60604@techsource.com>
Date: Wed, 25 Feb 2004 18:44:57 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA27D6@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA27D6@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nakajima, Jun wrote:
> For near branches (CALL, RET, JCC, JCXZ, JMP, etc.), the operand size is
> forced to 64 bits on both processors in 64-bit mode, basically meaning
> RIP is updated.
> 
> Compilers would typically use a JMP short for "intraprocedural jumps",
> which requires just an 8-bit displacement relative to RIP. 


I see.  It's too bad you can't have a 16-bit displacement.


Ummm... so if 66H were used with a near branch, would that affect the 
size of the immediate operand which gets added to RIP, or would that 
affect the the portion of IP/EIP/RIP affected?  If it's the latter, 
that's pretty silly.


