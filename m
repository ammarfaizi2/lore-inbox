Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSGTTYU>; Sat, 20 Jul 2002 15:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSGTTYU>; Sat, 20 Jul 2002 15:24:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52209 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317470AbSGTTYU>; Sat, 20 Jul 2002 15:24:20 -0400
Subject: Re: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amith Varghese <amith@xalan.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027048267.4537.185.camel@viper>
References: <1026941364.4547.91.camel@viper> 
	<1026966681.4537.119.camel@viper>  <1027048267.4537.185.camel@viper>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Jul 2002 21:39:28 +0100
Message-Id: <1027197568.16818.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 04:11, Amith Varghese wrote:
> Ok, I am still having problems booting 2.4.19-rc2-ac2.... I get an APIC
> error on CPU0 (and CPU1).  However, I tried 2.4.19-rc2 with my Promise
> SX6000 and get a slightly different result than 2.4.18.  It almost looks
> like the hard drives attached to the promise sx6000 are being
> initialized before it gets to the i2o code and the i2o block driver is
> unable to initialize /dev/i2o/hda (but thats a wild guess from my

They are. 2.4.19 base doesn't yet avoid them it seems. 

