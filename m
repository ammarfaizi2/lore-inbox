Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTGGAiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTGGAiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:38:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263765AbTGGAiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:38:11 -0400
Date: Sun, 6 Jul 2003 17:52:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: vincent.touquet@pandora.be
Cc: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp
 boot time problems too :(]
Message-Id: <20030706175232.470c4588.akpm@osdl.org>
In-Reply-To: <20030707003007.GE4675@ns.mine.dnsalias.org>
References: <20030706210243.GA25645@lea.ulyssis.org>
	<20030707003007.GE4675@ns.mine.dnsalias.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Touquet <vincent.touquet@pandora.be> wrote:
>
> Booting in smp mode now works using acpi=off and acpismp=force on the
> kernel command line.

Do 2.4 kernels boot both CPUs OK?  Do you use ACPI in 2.4?

The ACPI changes in 2.5 were recently merged into 2.4, so current
2.4 may be broken for you too.
