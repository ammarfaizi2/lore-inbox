Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVCAWDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVCAWDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVCAWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:03:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:10466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262084AbVCAWDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:03:22 -0500
Message-ID: <4224E6CE.2080701@osdl.org>
Date: Tue, 01 Mar 2005 14:03:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Vivek Goyal <vgoyal@in.ibm.com>, fastboot@lists.osdl.org,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [RFC][PATCH 3/3] Kdump: Export crash notes section
 address through sysfs
References: <1109261865.5148.819.camel@terminator.in.ibm.com> <20050228220502.177f75a1.akpm@osdl.org>
In-Reply-To: <20050228220502.177f75a1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
>>o Following patch exports kexec global variable "crash_notes" to user space
>>   through sysfs as kernel attribute in /sys/kernel.
> 
> 
> It breaks the x86_64 build.  A fix for that is below.
> 
> Please test kexec/kdump patches on all three architectures, both with your
> config option enabled and with it disabled.  There are cross-compilers at
> http://developer.osdl.org/dev/plm/cross_compile/

BTW:
You can download the cross_compile tools and run them yourself or you
can submit a patch to the PLM tool and it will run 8 arch. builds
for you....

-- 
~Randy
