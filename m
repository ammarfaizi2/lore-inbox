Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUFFUnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUFFUnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUFFUnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:43:09 -0400
Received: from pop.gmx.de ([213.165.64.20]:33510 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264124AbUFFUnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:43:07 -0400
X-Authenticated: #4512188
Message-ID: <40C381D7.5030406@gmx.de>
Date: Sun, 06 Jun 2004 22:43:03 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040604)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <200406070139.38433.kernel@kolivas.org>
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it is the first time I tried this scheduler with 2.6.7-rc2-mm2. A k.o 
criteria for me: Playing ut2004 it generated a lot of statics (sound 
wise). I consider this a regression in contrast to O(1). Nick's 
scheduler plays nice as well. For Nick's I have X reniced to -10. Your 
scheduler doesn't like this, as well: When plaing some tune via xmms and 
then switching to another (virtual) desktop, I get pops in the sound for 
fractions of a second. Putting X back to 0 fixes this. But I don't know 
how to "fix" ut2004 with staircase. :-(

Hth,

Prakash
