Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754185AbWKHEpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbWKHEpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbWKHEpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:45:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754185AbWKHEpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:45:04 -0500
Date: Tue, 7 Nov 2006 20:44:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
Message-Id: <20061107204440.090450ea.akpm@osdl.org>
In-Reply-To: <454E4941.7000108@qumranet.com>
References: <454E4941.7000108@qumranet.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Nov 2006 22:27:45 +0200
Avi Kivity <avi@qumranet.com> wrote:

> The following patchset adds a driver for Intel's hardware
> virtualization extensions to the x86 architecture. 

kapow.

{standard input}: Assembler messages:
{standard input}:157: Error: no such instruction: `vmxon -20(%ebp)'
{standard input}:176: Error: no such instruction: `vmxoff'
{standard input}:191: Error: no such instruction: `vmread %eax,%eax'
{standard input}:403: Error: no such instruction: `vmwrite %edx,%eax'
{standard input}:409: Error: no such instruction: `vmread %eax,12(%esp)'
{standard input}:568: Error: no such instruction: `vmread %edx,%edx'
{standard input}:596: Error: no such instruction: `vmclear -12(%ebp)'
{standard input}:1885: Error: no such instruction: `vmread %eax,4(%esp)'
{standard input}:1908: Error: no such instruction: `vmread %edx,%edx'
{standard input}:1912: Error: no such instruction: `vmread %eax,%eax'
{standard input}:1919: Error: no such instruction: `vmread %eax,%edx'
{standard input}:1948: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2148: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2230: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2249: Error: no such instruction: `vmread %edx,%edx'
{standard input}:2253: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2259: Error: no such instruction: `vmread %edx,%edx'
{standard input}:2263: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2334: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2358: Error: no such instruction: `vmread %edx,%edx'
{standard input}:2362: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2368: Error: no such instruction: `vmread %edx,%edx'
{standard input}:2372: Error: no such instruction: `vmread %eax,%eax'
{standard input}:2425: Error: no such instruction: `vmread %edx,%edx'
etcetera.


That's gas 2.16.1.  I assume it needs some super-new binutils.

I'm not sure what to do about this.  What's the minimum version?
