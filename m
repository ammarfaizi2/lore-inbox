Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVHPXud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVHPXud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVHPXud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:50:33 -0400
Received: from terminus.zytor.com ([209.128.68.124]:12248 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750749AbVHPXuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:50:32 -0400
Message-ID: <43027B9D.90107@zytor.com>
Date: Tue, 16 Aug 2005 16:49:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: zach@vmware.com, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwane@arm.linux.org.uk
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com> <20050816234725.GI27628@wotan.suse.de>
In-Reply-To: <20050816234725.GI27628@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, Aug 10, 2005 at 09:56:40PM -0700, zach@vmware.com wrote:
> 
>>Add an accessor function for getting the per-CPU gdt.  Callee must already
>>have the CPU.
> 
> 
> What is the accessor good for? 
> 
> It looks just like code obfuscation to me.

He wants accessors so he can override them in Xen.

	-hpa

