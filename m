Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWAPCF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWAPCF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWAPCF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:05:56 -0500
Received: from cable-212.76.255.90.static.coditel.net ([212.76.255.90]:897
	"EHLO jekyll.org") by vger.kernel.org with ESMTP id S932164AbWAPCFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:05:55 -0500
Message-ID: <43CAFF80.2020707@jekyll.org>
Date: Mon, 16 Jan 2006 03:05:52 +0100
From: Gilles May <gilles@jekyll.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP trouble
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got a wierd problem with my dual Athlon box.
The board is a K7D Master-L with 2 Athlon-MP 2800+ processors.
Running it with SMP enabled in the kernel makes it freeze on heavy 
activity. I can always reproduce a freeze
by watching a movie while copying files to/from USB disk, or on ping -f 
to a box on my LAN. Without SMP
support in the kernel I can do this for hours and no freeze.
The kernels I tried are ranging from 2.6.11-1.1369 (FC4) to 2.6.15 
vanilla kernel. Running from console
with no X nor any proprietary modules loaded.

I already tried diffent things to no avail like:
Different preemtion models
acpi=off on boot
Enable kernel irq balancing on/off
Lots of different BIOS setting (Using fail-safe most of the time though)

As my HW monitors tell me there's no overheating going on on any of the 
CPU's (at 53C and 54C now).

I'd be really grateful for any ideas / workarounds as I really don't 
know what to try anymore and a new machine is
out of the question financially.

Regards, Gilles May
