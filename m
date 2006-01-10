Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWAJGsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWAJGsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWAJGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:48:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbWAJGsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:48:39 -0500
Date: Mon, 9 Jan 2006 22:48:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-Id: <20060109224821.7a40bc69.akpm@osdl.org>
In-Reply-To: <20060109193754.GD12673@vanheusden.com>
References: <20060108114305.GA32425@vanheusden.com>
	<20060109041114.6e797a9b.akpm@osdl.org>
	<20060109144522.GB10955@vanheusden.com>
	<20060109193754.GD12673@vanheusden.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> wrote:
>
> > > Have you tried enabling the NMI watchdog?  Enable CONFIG_X86_LOCAL_APIC and
> > > boot with `nmi_watchdog=1' on the command line, make sure that the NMI line
> > > of /proc/interrupts is incrementing.
> > I'll give it a try. I've added it to the append-line in the lilo config.
> > Am now compiling the kernel.
> 
> No change. Well, that is: the last message on the console now is
> "setting eth1 to promiscues mode".
> 

Did you confirm that the NMI counters in /proc/interrupts are incrementing?
