Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVG3LxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVG3LxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVG3LxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:53:13 -0400
Received: from [195.144.244.147] ([195.144.244.147]:52439 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S263050AbVG3LxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:53:02 -0400
Message-ID: <42EB6A12.70100@varma-el.com>
Date: Sat, 30 Jul 2005 15:52:50 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gregkh@suse.de, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Where is place of arch independed companion chips?
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

While I write driver for SM501 CC (which have graphics controller, USB
MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
I bumped with next ambiguity:
Where is a place of this chip's Kconfig/drivers in
kernel config/drivers tree? May be create new node in drivers subtree?
Or put it under graphics node (since it's main function of this CC)?

AFAIK, this is not one such multifunctional monster in the world, so
somebody bumped with this problem again in future.

-- 
Regards
Andrey Volkov
