Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUEGXH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUEGXH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 19:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUEGXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 19:07:59 -0400
Received: from outbound03.telus.net ([199.185.220.222]:22160 "EHLO
	priv-edtnes12-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S263858AbUEGXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 19:07:56 -0400
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
From: Bob Gill <gillb4@telusplanet.net>
To: Alex Riesen <fork0@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040507110756.GA4647@linux-ari.internal>
References: <20040507110756.GA4647@linux-ari.internal>
Content-Type: text/plain
Message-Id: <1083958918.4734.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 07 May 2004 13:41:58 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, great!  Adding acpi=noirq to the kernel line made the lost interrupt
problem go away, and getting rid of rhgb on the same line made the
problems I had with nvidia drivers killing the system at the login
prompt (white screen, no kbd response) go away.
One goes in, one goes out! ;)

Thanks,
Bob  

On Fri, 2004-05-07 at 05:07, Alex Riesen wrote:
> >> zero IDE changes in bk6 -> bk8 but a lot of ACPI / IRQ related
> 
> it's bk8 which broke sis961 (or revealed it native brokenness)
> 
> > OK.  My APIC is a SiS961.
> 
> I have the same problem (and the same chipset).
> Passing acpi=noirq helps to work it around.
> 

