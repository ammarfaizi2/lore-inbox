Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVA2XKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVA2XKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVA2XKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:10:54 -0500
Received: from zork.zork.net ([64.81.246.102]:31951 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261587AbVA2XKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:10:50 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm2
References: <20050129131134.75dacb41.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 29 Jan 2005 23:10:47 +0000
In-Reply-To: <20050129131134.75dacb41.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 29 Jan 2005 13:11:34 -0800")
Message-ID: <6u3bwj7rwo.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a PowerBook (PowerBook5.4), when snd_powermac is modprobed during
the boot, I get the following.  After similar messages for a few more
modules, the machine seems wedged.

Reversed bk-driver-core.patch and rebuilt, same result.


kobject_register failed for snd_page_alloc (-17)
Call Trace:
  dump_stack
  kobject_register
  mod_sysfs_setup
  load_module
  sys_init_module
  ret_from_syscall
