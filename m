Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUEKOoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUEKOoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUEKOoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:44:24 -0400
Received: from terra.inf.ufsc.br ([150.162.60.10]:53730 "EHLO
	terra.inf.ufsc.br") by vger.kernel.org with ESMTP id S264770AbUEKOoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:44:22 -0400
Message-ID: <40A0E808.2020602@inf.ufsc.br>
Date: Tue, 11 May 2004 11:49:44 -0300
From: Thiago Robert <robert@inf.ufsc.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Write-combining
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there!

Is there an easy way to be sure about wether the PCI write-combining is 
enabled or not for a given memory region?

I'm writting user-level communication software for a Myrinet network. I 
use Write PIO and I'm aware that WPIO performance is greatly influencied 
by the presence of write combining. Based on the performance I measured 
I can only conclude that Write Combining is enabled but I would like to 
be sure about it (since I'm planning to publish my research).

Is the default behaviour of the Linux kernel to enable write-combining? 
How can I be sure if it is enabled or not?

Thanks in advance.

__________________________
Thiago Robert
