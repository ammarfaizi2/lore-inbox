Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWFPQuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWFPQuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFPQuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:50:21 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:31131 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S1751491AbWFPQuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:50:19 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: linux-kernel@vger.kernel.org
Cc: mchan@broadcom.com, netdev@vger.kernel.org
Subject: tg3 timeouts with 2.6.17-rc6
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: linux-kernel@vger.kernel.org, mchan@broadcom.com,
	netdev@vger.kernel.org
Date: Fri, 16 Jun 2006 18:50:12 +0200
Message-ID: <87psh9kptn.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing frequent network timeouts on my PowerMac G5 Quad with
2.6.17-rc6.  The timeouts are easily reproducible with moderate
network traffic, e.g. by using bittorrent.

,----
| NETDEV WATCHDOG: lan0: transmit timed out
| tg3: lan0: transmit timed out, resetting
| tg3: tg3_stop_block timed out, ofs=2c00 enable_bit=2
| tg3: tg3_stop_block timed out, ofs=1400 enable_bit=2
| tg3: lan0: Link is down.
| [...]
| tg3: lan0: Link is up at 1000 Mbps, full duplex.
| tg3: lan0: Flow control is on for TX and on for RX.
`----


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
