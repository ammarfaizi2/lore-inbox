Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbUB0XOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUB0XOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:14:45 -0500
Received: from main.gmane.org ([80.91.224.249]:28059 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263194AbUB0XOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:14:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mikep <mikpolniak@adelphia.net>
Subject: 2.6.3-mm4 does not find TV/FM audio chip=MSP34xx
Date: Fri, 27 Feb 2004 18:14:33 -0500
Message-ID: <c1oj0p$bn5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 69-161-69-17.bflony.adelphia.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Pinnacle TV/FM stereo card. The FM tuner audio chip MSP34xx is 
not found with 2.6.3-mm4. If i revert the bk-i2c.patch then it is 
detected and i have FM stereo sound again.

 From dmesg after the reverse:

bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3451G-A2 +nicam +simple +radio

