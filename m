Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUL0AI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUL0AI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUL0AI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:08:56 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:7574 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261415AbUL0AIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:08:55 -0500
Message-ID: <41CF528C.7090003@drzeus.cx>
Date: Mon, 27 Dec 2004 01:08:44 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: alan@lxorguk.ukuu.org.uk, Tommy.Reynolds@MegaCoder.com
Subject: ISA DMA demand mode (again)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago I asked why the linux ISA DMA code is locked to use 
only single mode but I didn't get much of a response. Now this has move 
from a curiosity to a necessity for my driver so I'm asking again. Using 
single mode I get transfer rates of 300 kBps. With demand mode I get 
1500 kBps. So you see why I'd like to use demand mode.

Side note: If I tell the DMA controller to do single mode and the chip 
to do demand I get 480 kBps. I find it amazing that it works at all in 
this case.

I included the people who helped me with the wonderful world of ISA DMA 
(;)) the last time in the hope that you might have some insight into this.

Rgds
Pierre
