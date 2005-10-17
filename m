Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVJQVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVJQVJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVJQVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:09:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932328AbVJQVJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:09:46 -0400
Date: Mon, 17 Oct 2005 14:09:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 dead in early boot
Message-Id: <20051017140906.0771f797.akpm@osdl.org>
In-Reply-To: <20051017210609.GA30116@aitel.hist.no>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<20051017210609.GA30116@aitel.hist.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> This one gets me a penguin on the framebuffer, and then dies
> with no further textual output.  
> numlock leds were working, and I could reboot with sysrq.

Can we get anything useful out of sysrq-p and sysrq-t?

Also, adding initcall_debug to the boot command line might help.

> Single opteron, Matrox G550 AGP framebuffer.  There is also
> a pci radeon in the machine, but no driver for it as X has
> to do int10 initialization first.

