Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTKYAY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTKYAY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:24:28 -0500
Received: from [202.181.197.10] ([202.181.197.10]:59406 "EHLO
	gandalf.gnupilgrims.org") by vger.kernel.org with ESMTP
	id S261777AbTKYAYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:24:24 -0500
Date: Tue, 25 Nov 2003 08:16:09 +0800
To: jt@hpl.hp.com
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Pavel Roskin <proski@gnu.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125001609.GA10153@gandalf.chinesecodefoo.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124235727.GA2467@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.28i
From: glee@gnupilgrims.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 03:57:27PM -0800, Jean Tourrilhes wrote:
> 	Hi,
> 
> 	I have a new Ricoh PCI-Carbus bridge and the kernel
> 2.6.0-test9 doesn't seem to configure it properly (see below).
> 	With the old Pcmcia package, the i82365 module had a bunch of
> module options to change various irq stuff (see Pcmcia Howto 5.2). A
> quick look in yenta_socket failed to show any module options, which
> seems odd.
> 	What is the correct way to workaround this stuff ?
> 


I have one of these cards.  In 2.4.x I used pci=biosirq to get around
it. (BTW, this will oops with a 2.2 kernel, just for the record).

	- g.

-- 
geoff.
