Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVAWJSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVAWJSw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAWJSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:18:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51972 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261201AbVAWJSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:18:50 -0500
Date: Sun, 23 Jan 2005 10:18:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: 2.6.11-rc2-kj
Message-ID: <20050123091849.GB3196@stusta.de>
References: <20050122235426.GB22170@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122235426.GB22170@nd47.coderock.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 12:54:26AM +0100, Domen Puncer wrote:
>...
> new in this release:
> --------------------
>...
> wait_event_int_t-drivers_input_joystick_iforce_iforce.h.patch
>   From: Nishanth Aravamudan <nacc@us.ibm.com>
>   Subject: [KJ] [PATCH 13/39] input/iforce-packets: use 	wait_event_interruptible_timeout()
>...

This patch causes two compile errors:

#ifdef CONFIG_JOYSTICK_IFORCE_USB:
- semicolon instead of opening bracket in line 265

#ifdef CONFIG_JOYSTICK_IFORCE_232:
- typo 'wait_event_interrutible_timeout'

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

