Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbTHSKQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTHSKQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:16:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:35782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269900AbTHSKQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:16:54 -0400
Date: Tue, 19 Aug 2003 03:17:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dumitru Ciobarcianu <cioby@ines.ro>
Cc: linux-kernel@vger.kernel.org, linux-acpi@unix-os.sc.intel.com
Subject: Re: 2.6.0-test3-mm3
Message-Id: <20030819031755.730e892b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308191302180.15679-100000@MailBox.iNES.RO>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<Pine.LNX.4.44.0308191302180.15679-100000@MailBox.iNES.RO>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumitru Ciobarcianu <cioby@ines.ro> wrote:
>
> 
> For some reason, the ACPI support depends on local apic.
> If you don't set "Local APIC support on uniprocessors" you can't enter in 
> the "ACPI Support" menu.
> 
> Is this really necessary ?
> 

There is a large change to drivers/acpi/Kconfig in Linus's post-test3 tree.

If you look at it, yes, everything in there has become dependent on
X86_LOCAL_APIC.   It looks like a mistake.

