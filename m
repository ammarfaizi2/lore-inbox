Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUL0CrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUL0CrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 21:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUL0CrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 21:47:08 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:3982 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261741AbUL0Cq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 21:46:58 -0500
Message-ID: <41CF77B6.7020501@verizon.net>
Date: Sun, 26 Dec 2004 21:47:18 -0500
From: Jim Nelson <james4765@verizon.net>
Reply-To: james4765@gmail.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cyclades: Put README.cycladeZ in Documentation/serial
References: <20041226135306.11762.53625.55036@localhost.localdomain> <20041226180228.GB17259@logos.cnet>
In-Reply-To: <20041226180228.GB17259@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 20:46:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi James,
> 
> Documentation/serial/ sounds fine to me, but the patch moves the file
> to Documentation/ ?
>  

Right.  I'll re-work and re-submit tomorrow.

Jim

> On Sun, Dec 26, 2004 at 07:52:46AM -0600, James Nelson wrote:
> 
>>Put README.cycladesZ in Documentation/serial.
>>
>>Firmware is still needed, but the README file shouldn't be in drivers/char.
>>
>>Signed-off-by: James Nelson <james4765@gmail.com>
>>
>>diff -urN --exclude='*~' linux-2.6.10-original/Documentation/README.cycladesZ linux-2.6.10/Documentation/README.cycladesZ
>>--- linux-2.6.10-original/Documentation/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
>>+++ linux-2.6.10/Documentation/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
>>@@ -0,0 +1,8 @@
>>+
>>+The Cyclades-Z must have firmware loaded onto the card before it will
>>+operate.  This operation should be performed during system startup,
>>+
>>+The firmware, loader program and the latest device driver code are
>>+available from Cyclades at
>>+    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
>>+
>>diff -urN --exclude='*~' linux-2.6.10-original/drivers/char/README.cycladesZ linux-2.6.10/drivers/char/README.cycladesZ
>>--- linux-2.6.10-original/drivers/char/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
>>+++ linux-2.6.10/drivers/char/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
>>@@ -1,8 +0,0 @@
>>-
>>-The Cyclades-Z must have firmware loaded onto the card before it will
>>-operate.  This operation should be performed during system startup,
>>-
>>-The firmware, loader program and the latest device driver code are
>>-available from Cyclades at
>>-    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
>>-
>>-
