Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUK0W32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUK0W32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUK0W32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:29:28 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48600 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261374AbUK0W3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:29:21 -0500
Subject: Re: ethernet Via-rhine driver 1.1.17 duplex detection issue in
	linux kernel 2.4.25
From: Lee Revell <rlrevell@joe-job.com>
To: Wenping Luo <wluo@fortinet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <011801c4d270$cca65740$0101140a@fortinet.com>
References: <011801c4d270$cca65740$0101140a@fortinet.com>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 17:29:18 -0500
Message-Id: <1101594559.15635.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 13:58 -0800, Wenping Luo wrote:
> I used crossed ethernet cable to connect one ethernet NIC to a Via Rhine III
> VT6105M NIC. I set the speed mode of Rhine Nic to be "auto" whereas I forced
> the peer NIC to be "100 Full Duplex". The Rhine NIC connected in mode of
> "100 Half Duplex" , instead of "100 Full Duplex", after detecting the peer.
> 
> I searched the Internet and I found another reported for similiar issue at
> http://lunar-linux.org/pipermail/lunar/2004-April/003894.html. However,
> there is no answer for this issue yet.
> 

Duplex detection is tricky, especially when one side is forced.  You
will get inconsistent results with all types of hardware.  Maybe this is
an unclear area in the Ethernet spec.  When I worked at a telco we had
this problem with Cisco gear, BSD/OS, Linux, Windows...  We just made
sure everything was either forced on both sides or auto everywhere.

Lee

