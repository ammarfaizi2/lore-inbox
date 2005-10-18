Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVJRAim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVJRAim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVJRAim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:38:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751382AbVJRAim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:38:42 -0400
Date: Mon, 17 Oct 2005 17:38:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 dead in early boot
Message-Id: <20051017173804.1529e3e6.akpm@osdl.org>
In-Reply-To: <20051017215343.GA30829@aitel.hist.no>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<20051017210609.GA30116@aitel.hist.no>
	<20051017140906.0771f797.akpm@osdl.org>
	<20051017215343.GA30829@aitel.hist.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> On Mon, Oct 17, 2005 at 02:09:06PM -0700, Andrew Morton wrote:
>  > Helge Hafting <helgehaf@aitel.hist.no> wrote:
>  > >
>  > > This one gets me a penguin on the framebuffer, and then dies
>  > > with no further textual output.  
>  > > numlock leds were working, and I could reboot with sysrq.
>  > 
>  > Can we get anything useful out of sysrq-p and sysrq-t?
>  > 
>  > Also, adding initcall_debug to the boot command line might help.
>  > 
>  Tried again without the framebuffer.  Still hanging, but more info:
> 
>  Last messages before getting stuck:
>  md autorun DONE
>  kjournald starting
>  Ext3-fs mounted fs w. ordered data mode
>  VFS mounted root (ext3) read-only
>  freeing unused kernel memory 216k freed.
>  warning-unable to open an initial console
>  kernel panic-not syncing:No init found. Try passing init= option to kernel
> 
> 
>  Somewhat silly. There certainly was a console (vgacon) or I wouldn't
>  be able to read the messages.  And if it mounted root, then there certainly
>  was an init to run also.

Can you send the .config please?
