Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753681AbWKRAbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbWKRAbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbWKRAbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:31:05 -0500
Received: from terminus.zytor.com ([192.83.249.54]:36503 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1753681AbWKRAbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:31:03 -0500
Message-ID: <455E540C.6090202@zytor.com>
Date: Fri, 17 Nov 2006 16:30:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 19/20] x86_64: Extend bzImage protocol for relocatable
 kernel
References: <20061117223432.GA15449@in.ibm.com> <20061117225826.GT15449@in.ibm.com>
In-Reply-To: <20061117225826.GT15449@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> 
> o Extend the bzImage protocol (same as i386) to allow bzImage loaders to
>   load the protected mode kernel at non-1MB address. Now protected mode
>   component is relocatable and can be loaded at non-1MB addresses.
> 
> o As of today kdump uses it to run a second kernel from a reserved memory
>   area.
> 
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>

Do you have a patch for Documentation/i386/boot.txt as well?

	-hpa
