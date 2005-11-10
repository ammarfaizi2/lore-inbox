Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVKJQGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVKJQGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVKJQGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:06:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41681 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751097AbVKJQGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:06:37 -0500
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43735DCA.7060107@rtr.ca>
References: <43720DAE.76F0.0078.0@novell.com>  <43722AFC.4040709@pobox.com>
	 <1131558785.6540.34.camel@localhost.localdomain>  <43735DCA.7060107@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Nov 2005 16:37:22 +0000
Message-Id: <1131640642.20099.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-10 at 09:48 -0500, Mark Lord wrote:
> Unless the target machine is modern (2005+ era) and has no serial ports,
> nor any way to add them other than via the USB stack.

Debugger USB serial isn't hard. A micro polled USB stack is tiny (see
for example the BIOS USB in a PC). You've also get ethernet and
firewire. gdb remote has supported ethernet for years along with just
about anything else you can get a bitstream in and out of.

Alan

