Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVJKUf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVJKUf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVJKUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:35:28 -0400
Received: from quark.didntduck.org ([69.55.226.66]:23261 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751321AbVJKUf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:35:27 -0400
Message-ID: <434C2269.5090209@didntduck.org>
Date: Tue, 11 Oct 2005 16:36:57 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jonathan M. McCune" <jonmccune@cmu.edu>
CC: linux-kernel@vger.kernel.org, Arvind Seshadri <arvinds@cs.cmu.edu>,
       Bryan Parno <parno@cmu.edu>
Subject: Re: using segmentation in the kernel
References: <434C1D60.2090901@cmu.edu>
In-Reply-To: <434C1D60.2090901@cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan M. McCune wrote:
> Hello,
> 
> We're starting work on a project for the 32-bit x86 Linux kernel that
> involves using segmentation in the kernel. As a first effort, we'd
> like to adjust the kernel code and data segment descriptors so that
> the kernel code, and data segment, bss, heap and stack exist in linear
> address range between 3GB and 4 GB. How could we implment this so that
> it breaks the memory management subsystem the least (or not at all if
> we are lucky ;-))?

Why send the kernel back to the 2.0 days?  There is no valid reason for 
doing this with they way x86 segmentation works, which is why it was 
done away with in 2.1.

--
				Brian Gerst
