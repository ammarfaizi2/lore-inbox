Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJTSfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTJTSfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:35:08 -0400
Received: from [65.172.181.6] ([65.172.181.6]:62857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262714AbTJTSfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:35:04 -0400
Date: Mon, 20 Oct 2003 11:44:11 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Add error handling to software_suspend
In-Reply-To: <20031018210705.GA22191@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310201143250.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This adds error handling to software_suspend(), and kills
> software_suspend_enabled variable; it is cleaner that
> way. do_software_suspend() is now gone. __read_suspend_image can be
> init, so mark it as such to avoid tool warnings. Add prototypes for
> freeze_processes and thaw_proceses (or are those elsewhere,
> already?). 

They're in kernel/power/power.h, which swsusp.c already includes. I'll 
apply the rest. 

Thanks,


	Pat



