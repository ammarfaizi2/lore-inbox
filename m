Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136638AbREAQGd>; Tue, 1 May 2001 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136641AbREAQGN>; Tue, 1 May 2001 12:06:13 -0400
Received: from [209.202.46.62] ([209.202.46.62]:21009 "HELO fluke.haryan.to")
	by vger.kernel.org with SMTP id <S136638AbREAQGC>;
	Tue, 1 May 2001 12:06:02 -0400
Date: Tue, 1 May 2001 11:05:12 -0500
From: Ronny Haryanto <ronny-linux@haryan.to>
To: linux-kernel@vger.kernel.org
Subject: tulip driver broken in 2.4.4?
Message-ID: <20010501110512.A8148@haryan.to>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: Get my public key from http://ronny.haryan.to/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried 2.4.4 yesterday and found that my eth1 was dead after 5 minutes.
The log says:

Apr 30 10:30:59 fluke kernel: NETDEV WATCHDOG: eth1: transmit timed out 
Apr 30 10:30:59 fluke kernel: eth1: Transmit timed out, status fc664010, CSR12 00000000, resetting... 
Apr 30 10:31:07 fluke kernel: NETDEV WATCHDOG: eth1: transmit timed out 
Apr 30 10:31:07 fluke kernel: eth1: Transmit timed out, status fc664010, CSR12 00000000, resetting...  
... and so on repeatedly ...

I had to ifdown-ifup cycle to re-enable it but it's dead again after 5
minutes with the same problem. The card is LinkSys LNE100TX v4.1. It is
currently working fine with 2.2.18. If there's any other info that is needed
please let me know.

Ronny
