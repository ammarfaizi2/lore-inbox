Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVASMKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVASMKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVASMKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:10:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15755 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261699AbVASMKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:10:31 -0500
Message-ID: <41EE4E30.6060908@in.ibm.com>
Date: Wed, 19 Jan 2005 17:40:24 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/29] x86-kexec
References: <overview-11061198973484@ebiederm.dsl.xmission.com>	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com> <x86-kexec-11061198971773@ebiederm.dsl.xmission.!
 com>
In-Reply-To: <x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

Eric W. Biederman wrote:
> This is the i386 implementation of kexec.

I tried these patches on an i386 box with kexec-tools-1.99. 
kexec-ing with vmlinux works fine but bzImage still doesnt 
go through. Is there a newer kexec-tools package that we 
need to use this with (to take care of the "purgatory code 
getting overwritten" problem you had identified).

Regards, Hari
