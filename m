Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUEQLx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUEQLx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbUEQLx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:53:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12425 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264948AbUEQLx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:53:26 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: 2.6.6-mm3
References: <20040516025514.3fe93f0c.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 May 2004 05:52:09 -0600
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>
Message-ID: <m1r7tji846.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh... This almost worked.  We now have sys_kexec_load reserved on all
architectures except x86.

It looks like Randy Dunlap generated an incremental patch to reserve the
syscall on other architectures, and you treated it as an update.

Eric


Andrew Morton <akpm@osdl.org> writes:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm3/
> -kexec-reserve-syscall-slot.patch

> +kexec-reserve-syscall-slot.patch
> 
>  Reserve the kexec syscall slot on supported architectures.

> kexec-reserve-syscall-slot.patch
>   reserve syscall slots for kexec
