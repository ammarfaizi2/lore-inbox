Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbULKPlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbULKPlp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbULKPlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:41:45 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:51585 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261949AbULKPld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:41:33 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1102776772.2968.4.camel@rousalka.dyndns.org>
References: <1102776772.2968.4.camel@rousalka.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Sat, 11 Dec 2004 10:41:32 -0500
Message-Id: <1102779692.3501.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 15:52 +0100, Nicolas Mailhot wrote:
> Just FYI real-time kernels do not boot on my Fedora Devel (Rawhide)
> system, including -RT-2.6.10-rc2-mm3-V0.7.32-12. 2.6.10-rc2-mm4 OTOH
> boots fine. It freezes just after initial hardware init before going
> into gfx mode.
> 
> (kernel config available on demand, it's almost the same - 2.6.10-rc2-
> mm4 was generated using a make oldconfig on the -RT-2.6.10-rc2-mm3-
> V0.7.32-12 file)

Do you have CONFIG_PCI_MSI set? If you do, then I already sent in a
patch to Ingo. It had a problem with interrupts, and if I had anything
plugged into the USB port, it would hang too.

-- Steve

