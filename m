Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVCRGo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVCRGo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 01:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVCRGo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 01:44:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:58335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261473AbVCRGoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 01:44:24 -0500
Date: Thu, 17 Mar 2005 22:44:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc64 build broke between 2.6.11-bk6 and 2.6.11-bk7
Message-Id: <20050317224409.41f0f5c5.akpm@osdl.org>
In-Reply-To: <445800000.1111127533@[10.10.2.4]>
References: <445800000.1111127533@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> drivers/built-in.o(.text+0x182bc): In function `.matroxfb_probe':
> : undefined reference to `.mac_vmode_to_var'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Anyone know what that is?
> 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/broken-out/fbdev-kconfig-fix-for-macmodes-and-ppc.patch

should fix it.
