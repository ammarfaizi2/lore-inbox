Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTIHTJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTIHTJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:09:51 -0400
Received: from [192.107.131.136] ([192.107.131.136]:25567 "EHLO
	nelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S263505AbTIHTJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:09:49 -0400
Message-ID: <3F5CD45A.2060207@sedsystems.ca>
Date: Mon, 08 Sep 2003 13:11:22 -0600
From: Kendrick Hamilton <hamilton@sedsystems.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Timer Interrupts, please CC hamilton@sedsystems.ca
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    Please send/cc responses to hamilton@sedsystems.ca
    We are using a custom modulator card with the Linux 2.2.16 kernel 
running on an IBM e-server (dual 2.8GHz, a lot of RAM). The modulator 
card uses interrupts to send data (the card has a large FIFO and 
interrupts when almost empty). The interrupt service routine re-fills 
the fifo. While it is re-filling the FIFO interrupts are disabled. We 
are noticing horrible clock skew.
    Can you tell me the frequency of timer interrupts used by the linux 
2.2.16 kernel on Intel x86 SMP platform. I want to know how long my 
interrupt service routine can leave the interrupt disabled.
    TIA
Kendrick Hamilton
hamilton@sedsystems.ca


