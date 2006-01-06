Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752327AbWAFAjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbWAFAjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbWAFAjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:39:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752278AbWAFAjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:39:41 -0500
Date: Thu, 5 Jan 2006 16:38:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: vgoyal@in.ibm.com, ak@muc.de, ebiederm@xmission.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linuxbios@openbios.org
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Message-Id: <20060105163848.3275a220.akpm@osdl.org>
In-Reply-To: <86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
References: <20060103044632.GA4969@in.ibm.com>
	<86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu <yinghai.lu@amd.com> wrote:
>
> the patch is good.
> 
> I tried LinuxBIOS with kexec.
> 
> without this patch: I need to disable acpi in kernel. otherwise the
> kernel with acpi support can boot the second kernel, but the second
> kernel will hang after
> 
> time.c: Using 14.318180 MHz HPET timer.
> time.c: Detected 2197.663 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Memory: 1009152k/1048576k available (2967k kernel code, 39036k reserved, 1186k )
> 
> 

Please don't top-post.

> 
> On 1/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > Hi Andi,
> >
> > Can you please include the following patch. This patch has already been pushed
> > by Andrew.
> >
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch

IIRC, I dropped this patch because of discouraging noises from Andi and
because underlying x86_64 changes broke it in ugly ways.  It needs to be
redone and Andi's objections (whatever they were) need to be addressed or
argued about.

Right now the patch is rather dead.
