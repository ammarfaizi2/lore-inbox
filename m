Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUBSUi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUBSUi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:38:26 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:51210
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267557AbUBSUiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:38:21 -0500
Date: Thu, 19 Feb 2004 12:39:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-ID: <20040219203919.GA8285@atomide.com>
References: <20040219183448.GB8960@atomide.com> <20040220171337.10cd1ae8.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220171337.10cd1ae8.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [040219 11:24]:
> 
> You need the appended patch to build on Uni Processor again. I already
> submitted it to Linus, but he doesn't seem to have merged it yet
> (or alternatively compile for SMP) 

OK, that compiles, but does not boot. Tt's not the *.S files, not the 
*.c, files, I think it's in the .h files somewhere.

Undoing *.S files did not help. Undoing *.c files did not help. 
Finally undoing the *.h files booted... I'll try to narrow it down more.

Yeah, this is UP machine. Also just remembered I don't have a serial port
for lowe level printk's :)

Tony
