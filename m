Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270446AbUJUCqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270446AbUJUCqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbUJUCkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:40:41 -0400
Received: from smtp1.ensim.com ([65.164.64.254]:5940 "EHLO smtp1.ensim.com")
	by vger.kernel.org with ESMTP id S270605AbUJUCir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:38:47 -0400
From: Borislav Deianov <borislav@users.sourceforge.net>
Date: Wed, 20 Oct 2004 19:38:43 -0700
To: "Yu, Luming" <luming.yu@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Message-ID: <20041021023843.GO17013@aero.ensim.com>
References: <3ACA40606221794F80A5670F0AF15F8405DCA922@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8405DCA922@pdsmsx403>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 21 Oct 2004 02:37:52.0494 (UTC) FILETIME=[F67060E0:01C4B716]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:18:08AM +0800, Yu, Luming wrote:
> 
> I'm working on a generic hotkey driver, which will move configurable 
> stuff to user space. 
[snip]
> 1. add a new hotkey:
>  echo "0 : _SB.VGA : _SB.VGA.LCD._BCM :0x86 : 0x86" >
> /proc/acpi/ev_config

How would user space know what devices and methods to use? In the
kernel, you can use HIDs where available, or check for specific
objects with acpi_get_handle(). Are you going to expose these to user
space somehow?

Boris
