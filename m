Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbTGEUBC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbTGEUBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:01:02 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:23312 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S266442AbTGEUBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:01:01 -0400
Date: Sat, 05 Jul 2003 14:15:24 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jim Gifford <maillist@jg555.com>,
       Roberto Slepetys Ferreira <slepetys@homeworks.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Message-ID: <2268760000.1057436124@aslan.scsiguy.com>
In-Reply-To: <14a301c341b7$7ff0bd50$3400a8c0@W2RZ8L4S02>
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com>
 <01b101c340dc$ede386c0$3300a8c0@Slepetys> <016901c34191$14c4a1c0$3300a8c0@Slepetys> <13e101c3419d$f62f9410$3400a8c0@W2RZ8L4S02>
 <01f101c3419f$e6d30360$3300a8c0@Slepetys> <913060000.1057267206@aslan.btc.adaptec.com> <14a301c341b7$7ff0bd50$3400a8c0@W2RZ8L4S02>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin, I just tried to enable the nmi watch dog. It doesn't seem to work on
> my system I tried both
> 
> append="nmi_watchdog=1"
> and
> append="nmi_watchdog=2"

Is the watchdog enabled in your kernel?  The command line only works
if you have compiled in support for the watchdog.

--
Justin

