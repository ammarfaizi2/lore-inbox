Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTLJRA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTLJRA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:00:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:14548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263751AbTLJRA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:00:56 -0500
Date: Wed, 10 Dec 2003 08:52:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23: pc_keyb.c] request_irq() without free_irq().
Message-Id: <20031210085255.53747fde.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0312101527510.1130-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0312101527510.1130-100000@pcgl.dsa-ac.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 15:32:22 +0100 (CET) Guennadi Liakhovetski <gl@dsa-ac.de> wrote:

| Hello
| 
| Looks like the the counterpart for kbd_request_irq() is missing. Am I
| right?

Did you find the counterpart for kbd_request_region()?

In 2.4.x, the pc keyboard driver option is Y/N.  It can't be a module.
If it's built into the kernel, it just hangs around until reboot.
It doesn't need to release resources when the kernel is shutting down.

--
~Randy
MOTD:  Always include version info.
