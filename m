Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264495AbUEDTpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbUEDTpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUEDTpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:45:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264495AbUEDTo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:44:58 -0400
Date: Tue, 4 May 2004 12:44:37 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vanja Hrustic <vanja@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: USB problems: SanDisk SDDR-75 / Apacer AP-MSCRU10 card readers
Message-Id: <20040504124437.2509af87.zaitcev@redhat.com>
In-Reply-To: <20040504130456.GB9161@logos.cnet>
References: <20040504130456.GB9161@logos.cnet>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Vanja Hrustic <vanja@pobox.com>
> Date:	Mon, 19 Apr 2004 14:50:24 +0200

> I have purchased SanDisk SDDR-75 card reader, since it was reported on
> quite few places to work (even with RH 7.3) ok on Linux.
> However, I am experiencing problems with it, as well as with another
> reader I have (Apacer AP-MSCRU10).
> 
> Kernel is 2.4.26 (tried 2.4.25 as well), on RedHat 9. System is XP2500, on
> NForce2 motherboard.

> I can provide much more details []

At this point I suspect SMP (of hyperthreaded variety, perhaps).
I must admit there's little chance I might be able to look at this
in detail. Do this... get dmesg, /proc/interrupts, /proc/bus/usb/devices,
/proc/cpuinfo. The /var/log/messages is a substitute for dmesg,
but we'll need a complete one. Send it to
linux-usb-devel@lists.sourceforge.net and
perhaps cc: to mdharm-usb at one-eyed-alien not net.
nForce is known to be kinky, although I cannot quite put my
finger on it.

-- Pete
