Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWHAU0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWHAU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWHAU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:26:15 -0400
Received: from terminus.zytor.com ([192.83.249.54]:32955 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161039AbWHAU0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:26:14 -0400
Message-ID: <44CFB8C4.8060904@zytor.com>
Date: Tue, 01 Aug 2006 13:25:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060801192628.GE7054@in.ibm.com>
In-Reply-To: <20060801192628.GE7054@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> 
> Hi Eric,
> 
> Can't we use the x86_64 relocation approach for i386 as well? I mean keep
> the virtual address space fixed and updating the page tables. This would
> help in the sense that you don't have to change gdb if somebody decides to
> debug the relocated kernel.
> 
> Any such tool that retrieves the symbol virtual address from vmlinux will
> be confused.
> 

I don't think this is practical given the virtual space constraints on 
i386 systems.

	-hpa

