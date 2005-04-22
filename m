Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVDVMiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVDVMiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 08:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVDVMiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 08:38:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31431 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261312AbVDVMiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 08:38:18 -0400
To: Nagesh Sharyathi <sharyathi@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, akpm@osdl.org
Subject: Re: [Fastboot] Re: Kdump Testing
References: <OF3AAC7ED2.37502955-ON65256FEB.0039D16D-65256FEB.003BB61C@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Apr 2005 06:32:32 -0600
In-Reply-To: <OF3AAC7ED2.37502955-ON65256FEB.0039D16D-65256FEB.003BB61C@in.ibm.com>
Message-ID: <m1is2f9elb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagesh Sharyathi <sharyathi@in.ibm.com> writes:

> Here is the console boot log, before the machine jumps to BIOS 
> after hang during panic kerenl boot

Ok thanks.  So this is manually triggered with SysRq
and the kexec part works but the recover kernel simply fails
to boot.

It looks like that hunk of the ACPI code that messes up maxcpus=1
needs to be looked at.

Eric
