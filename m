Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUI1K5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUI1K5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUI1K5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:57:14 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:26412 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266854AbUI1K5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:57:12 -0400
Message-ID: <81b0412b04092803576ced6572@mail.gmail.com>
Date: Tue, 28 Sep 2004 12:57:12 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Aboo Valappil <aboo@aboosplanet.com>
Subject: Re: Switch back to Real mode and then boot strap
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NAYArRjbDt3HvoFOAmE00000009@naya.ABOOSPLANET.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <81b0412b0409280321235178f1@mail.gmail.com>
	 <NAYArRjbDt3HvoFOAmE00000009@naya.ABOOSPLANET.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 20:46:40 +1000, Aboo Valappil <aboo@aboosplanet.com> wrote:
> Thanks for your reply, it is really good if I have to load another kernel.
> But in my case the OS on the hard disk could be Windows, Linux or x86
> Solaris. A reboot is required from Linux booted from floppy/ramdisk after
> the hard disk has been imaged with requested operating system by a user.

Could be a starting point, though.

> Because of the automated behavior of this, changing the boot sequence is not
> an option. That is why I am after executing real mode BIOS interrupts to
> load the MBR and then pass control to it.

You still have to shutdown the currently running kernel and put the
devices in some
definite state.
