Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273019AbTHPObK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273021AbTHPObK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:31:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41602 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S273019AbTHPOa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:30:58 -0400
Date: Sat, 16 Aug 2003 15:29:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rob Landley <rob@landley.net>
Cc: George Anzinger <george@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-laptop@vger.kernel.org
Subject: APM and 2.5.75 not resuming properly
Message-ID: <20030816142933.GE23646@mail.jlokier.co.uk>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308132024.36967.rob@landley.net> <3F3B41C7.1000906@mvista.com> <200308160510.44627.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308160510.44627.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> (APM suspends, and then never comes back until you yank the #*%(&#
> battery.  Great.  Trying it with the real mode bios calls next
> reboot...)

Similar here.  Using 2.5.75.  APM with no local APIC (kernel is unable
to enable it anyway).

It suspends.  On resume, the screen is blank and the keyboard doesn't
respond (no Caps Lock or SysRq).  Occasionally when it resumes the
keyboard does respond, but the screen stays blank.  At least it is
possible to do SysRq-S SysRq-B in this state.  Sometimes, if I'm
lucky, I can make it reboot by holding down the power key for 5 seconds.

2.4 APM works great.  ACPI doesn't do anything useful except give me
more control over the screen brightness.

--- Jamie
