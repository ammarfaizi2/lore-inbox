Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272323AbTHEAsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTHEAsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:48:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:30683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272323AbTHEAsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:48:51 -0400
Date: Mon, 4 Aug 2003 17:53:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Split SOFTWARE_SUSPEND and ACPI_SLEEP
In-Reply-To: <20030726223958.GA473@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041752180.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Splits two config options to avoid user confusion. Patrick already has
> better version of that patch in his tree, and probably wants to avoid
> applying this.

Correct, I opted for my version, which moves kernel/suspend.c to 
kernel/power/swsusp.c, and moves the refrigerator code to process.c in 
that directory.

I have patches available, and will be posting them shortly. 


	-pat

