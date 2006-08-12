Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWHLTkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWHLTkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWHLTkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:40:51 -0400
Received: from rooties.de ([83.246.114.58]:33998 "EHLO rooties.de")
	by vger.kernel.org with ESMTP id S964947AbWHLTkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:40:51 -0400
From: Daniel <damage@rooties.de>
To: linux-kernel@vger.kernel.org
Subject: debug prism wlan
Date: Sat, 12 Aug 2006 21:40:44 +0000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122140.44365.damage@rooties.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
my wlan gives up working somewhere between upgrading to gcc-4.1, changing some 
kernel options and upgrading to linux-2.8.16-r4.

Now I get following from iwconfig:

eth2      NOT READY!  ESSID:off/any
          Mode:Master  Channel:0  Access Point: Not-Associated
          Tx-Power=31 dBm   Sensitivity=0/200
          Retry min limit:0   RTS thr=-1 B   Fragment thr=-1 B
          Encryption key:off
          Link Quality:27  Signal level:0  Noise level:0
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

But I'm not able to get infromation why this device isn't ready.
dmesg is not reporting an error.

So, has someone an idea of how to get some informations to solve this problem?

regards
Daniel
