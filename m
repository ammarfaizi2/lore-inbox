Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTKYAdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTKYAdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:33:32 -0500
Received: from bolt.sonic.net ([208.201.242.18]:42441 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S261831AbTKYAda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:33:30 -0500
Date: Mon, 24 Nov 2003 16:26:28 -0800
From: David Hinds <dhinds@sonic.net>
To: jt@hpl.hp.com
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031124162628.A32213@sonic.net>
References: <20031124235727.GA2467@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124235727.GA2467@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.22.1i
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

Does this system do ACPI?  Do you have that configured in your kernel?

The yenta module doesn't have any options for overriding interrupt
settings.  It relies on the PCI subsystem has to do the right thing.

-- Dave
