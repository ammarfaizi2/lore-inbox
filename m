Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVIKRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVIKRPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVIKRPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:15:46 -0400
Received: from smtp.telecable.es ([212.89.0.3]:34519 "EHLO smtp.telecable.es")
	by vger.kernel.org with ESMTP id S1751086AbVIKRPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:15:46 -0400
Date: Sun, 11 Sep 2005 19:15:32 +0200
From: Miguel <frankpoole@terra.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PCI bug in 2.6.13
Message-Id: <20050911191532.7aa81b11.frankpoole@terra.es>
In-Reply-To: <Pine.LNX.4.58.0509110903050.4912@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
	<20050909225956.42021440.akpm@osdl.org>
	<20050910113658.178a7711.frankpoole@terra.es>
	<Pine.LNX.4.58.0509100949370.30958@g5.osdl.org>
	<Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
	<20050911030814.08cbe74c.frankpoole@terra.es>
	<Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
	<20050911161058.481d1a75.frankpoole@terra.es>
	<Pine.LNX.4.58.0509110903050.4912@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus:

> Change the pci_write_config_byte() into a pci_write_config_dword(), and I 
> bet it works. 

It works!

> However, I _also_ suspect it works if you remove those lines entirely. I 
> don't see why it tries to enable the ROM in the first place - it doesn't 
> seem to be _using_ it.

I have also tried that and it works too.

Thank you.
