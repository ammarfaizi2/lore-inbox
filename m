Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130248AbRBUXKe>; Wed, 21 Feb 2001 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130504AbRBUXKY>; Wed, 21 Feb 2001 18:10:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63245 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130248AbRBUXKQ>; Wed, 21 Feb 2001 18:10:16 -0500
Subject: Re: Linux 2.4.1ac20
To: cowboy@vnet.ibm.com (Richard A Nelson)
Date: Wed, 21 Feb 2001 23:13:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0102211758510.2261-100000@badlands.lexington.ibm.com> from "Richard A Nelson" at Feb 21, 2001 06:06:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ViS0-0002yt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only candidates (it was a trivially small patch) seem to be:
> the two additions:  dev->last_rx = jiffies ; I'll bet that at least

Can you stick an if(dev!=NULL) in front of that and let me know if that
fixes it - just to verify thats the problem spot
