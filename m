Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVAaHVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVAaHVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVAaHVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:21:06 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:40396 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S261893AbVAaHVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:21:01 -0500
Message-ID: <41FDDCA3.7090701@cs.aau.dk>
Date: Mon, 31 Jan 2005 08:22:11 +0100
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Watchdog] alim7101_wdt problem on 2.6.10
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Vaio C1MZX and in the lspci I saw this line:
0000:00:11.0 Non-VGA unclassified device: ALi Corporation M7101 Power
Management Controller [PMU]

So, I assumed it was a watchdog and I compiled with the option:
CONFIG_ALIM7101_WDT=m

But, when I do: modprobe alim7101_wdt

I get the following error message:

Jan 30 00:58:21 hermes vmunix: alim7101_wdt: Steve Hill
<steve@navaho.co.uk>.
Jan 30 00:58:21 hermes vmunix: alim7101_wdt: ALi 1543 South-Bridge does
not have the correct revision number (???1001?) - WDT
not set

What did I do wrong ?

If some patches need to be tried out, I volunteer. :)

Thanks in advance for you reply
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.aau.dk

