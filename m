Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUE1Xsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUE1Xsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 19:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUE1Xsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 19:48:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:23504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264082AbUE1Xsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 19:48:38 -0400
Date: Fri, 28 May 2004 16:51:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1 lockup
Message-Id: <20040528165119.01a96be8.akpm@osdl.org>
In-Reply-To: <40B7CD1D.1070606@blueyonder.co.uk>
References: <40B7CD1D.1070606@blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> A7N8X-E motherboard, IDE HD's hda and hdc. Hangs forever as shown below. 
> SYSRQ does nothing, needs a hard reset. 2.6.5-mm5 boots OK as does 
> vanilla 2.6.7-rc1 which was built after 3 reboots of 2.6.7-rc1-mm1 hung.

Could you try adding `nmi_watchdog=1' to the boot command line?  Make sure
that CONFIG_X86_LOCAL_APIC is enabled in kernel config.
