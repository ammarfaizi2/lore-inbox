Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUIATiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUIATiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUIATiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:38:00 -0400
Received: from serv4.servweb.de ([82.96.83.76]:38026 "EHLO serv4.servweb.de")
	by vger.kernel.org with ESMTP id S267424AbUIAThb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:37:31 -0400
Date: Wed, 1 Sep 2004 21:36:01 +0200
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Subject: cdrecord problem. (hdc: status error: status=0x50 { DriveReady SeekComplete })
Message-ID: <20040901193601.GA1344@erdbeere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.6+20040722i
X-scanner: scanned by Inflex 1.0.12.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i have some trouble with cdrecord, but no idea where to search or where
to ask - i hope this is the right place.

mounting the cd or play audio tracks work just fine, but if i start to
use cdrecord i got this [1] messages on the screen and in the dmesg. the 
first time i've seen the problem was with 2.6.8 and now i work with 
2.6.9-rc1 - i thought this could be a known and fixed problem, but i
have the same problem.

tomorrow i will try it with an older kernel (maybe 2.6.2). if you have
any other idea how to find this problem, please send me an e-mail

thanks,
patrick

[1]
hdc: CHECK for good STATUS
hdc: status error: status=0x50 { DriveReady SeekComplete }
hdc: status error: error=0xd0LastFailedSense 0x0d
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0xd0LastFailedSense 0x0d
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset timed-out, status=0x80
ide1: reset: success
hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0xd0LastFailedSense 0x0d
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: status error: error=0x01IllegalLengthIndication
hdc: drive not ready for command
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0xd0LastFailedSense 0x0d
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: status error: error=0x01IllegalLengthIndication
hdc: drive not ready for command
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0xd0LastFailedSense 0x0d
hdc: drive not ready for command
[...]
