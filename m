Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTJTTOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTJTTOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:14:17 -0400
Received: from gprs144-63.eurotel.cz ([160.218.144.63]:1153 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262669AbTJTTOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:14:05 -0400
Date: Mon, 20 Oct 2003 21:13:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Add error handling to software_suspend
Message-ID: <20031020191358.GA540@elf.ucw.cz>
References: <20031018210705.GA22191@elf.ucw.cz> <Pine.LNX.4.44.0310201143250.13116-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310201143250.13116-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds error handling to software_suspend(), and kills
> > software_suspend_enabled variable; it is cleaner that
> > way. do_software_suspend() is now gone. __read_suspend_image can be
> > init, so mark it as such to avoid tool warnings. Add prototypes for
> > freeze_processes and thaw_proceses (or are those elsewhere,
> > already?). 
> 
> They're in kernel/power/power.h, which swsusp.c already includes. I'll 
> apply the rest. 

Thanks.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
