Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUKHQjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUKHQjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKHQg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:36:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:56762 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261900AbUKHO4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:56:30 -0500
Message-ID: <418F3C81.9060302@suse.de>
Date: Mon, 08 Nov 2004 10:29:37 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
References: <200411062014.08202.rjw@sisk.pl>
In-Reply-To: <200411062014.08202.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

> Third, some important messages related to suspend/resume do not appear on the 
> serial console (eg the above  ALSA messages, the "[nosave pfn 0x584]..." 
> etc.), so I can't save them if the box hangs or reboots in the process.

dmesg -n 8
(before suspend) may help with this.

    Stefang

