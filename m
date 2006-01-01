Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWAAXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWAAXor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWAAXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 18:44:47 -0500
Received: from mail.gmx.de ([213.165.64.21]:18643 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932287AbWAAXor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 18:44:47 -0500
X-Authenticated: #527675
Message-ID: <43B8696B.2070303@gmx.de>
Date: Mon, 02 Jan 2006 00:44:43 +0100
From: Reinhard Nissl <rnissl@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SysReq & serial console
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm facing a similar issue like the thread

system keeps freezing once every 24 hours / random apps crashing

reported, but I still have to try all those suggestions.

For now, I've configured a serial console and enabled SysReq. When the 
freeze happens on my system, the system is still pingable and SysReq can 
for example sync the disks. I also can see on serial console which 
SysReq command I selected (registers, tasks, SAK, etc.), but I do not 
get any output of these commands on serial console.

When issuing such a SysReq command before the system freezes I can see 
the output of the command on a framebuffer console.

So, is it possible to redirect the output of a SysReq command to a 
serial console?

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
