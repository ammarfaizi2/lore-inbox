Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTGRNbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbTGRNbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:31:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:37582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265772AbTGRNbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:31:04 -0400
Date: Fri, 18 Jul 2003 06:44:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: <torvalds@transmeta.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make CONFIG_ACPI_SLEEP independend on CONFIG_SOFTWARE_SUSPEND
In-Reply-To: <20030718091252.GA280@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0307180641110.876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I do not really like the placement; process suspension is not really a
> device driver. What about kernel/power/*.c, instead?

The only reason I put it there is because the new PM code that I've been 
working on contains an abstraction layer and registration mechanism for 
the architecture-specific PM hooks (i.e. drivers for the low-level 
code), and it will contain the driver suspend/resume code. 

It seemed as good a place as any for it, though I personally don't have a
preference. Does anyone else care? 


	-pat

