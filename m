Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVBZOUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVBZOUg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 09:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVBZOUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 09:20:34 -0500
Received: from expredir4.cites.uiuc.edu ([128.174.5.187]:34261 "EHLO
	expredir4.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S261203AbVBZOU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 09:20:28 -0500
From: Paul Miller <paul@pinheiro.dyndns.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: pc104 ISA bus-mastering & custom hardware
Date: Sat, 26 Feb 2005 08:20:30 -0600
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502260820.30875.paul@pinheiro.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been thinking about fabricating my own hardware for a pc104 board 
that uses a 16-bit ISA bus.  Basically, I want to interface a DSP 
such that it has access to the pc104's shared memory.  I'm fairly 
confident that I can work out the circuit design, but I need to know 
more about Linux's ISA support.

1) What is needed to support ISA bus-mastering?  I would like the ISA 
device to write directly to the pc104's shared memory.

2) What memory regions can I write to?  Am I limited to <16MB or is it 
more restrictive?  64K-1MB, 15-16MB?

3) How can I reserve a specific memory region?  How much memory can I 
use?  I plan to have a way to communicate to the DSP (via I/O) what 
memory address to access.

4) How do I enable a 16-bit DMA channel?  Do I need to do anything 
beyond enabling DMA?

5) What are some good examples?

6) What else should I be thinking about?

Thanks!
-Paul
