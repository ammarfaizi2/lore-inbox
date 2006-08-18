Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWHRTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWHRTbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWHRTbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:31:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15551 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932243AbWHRTbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:31:09 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Raphael Hertzog <hertzog@debian.org>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060817161042.GC10818@ouaza.com>
References: <20060816104559.GF4325@ouaza.com>
	 <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com>
	 <1155762739.7338.18.camel@mindpipe>
	 <1155767066.2600.19.camel@localhost.localdomain>
	 <20060817161042.GC10818@ouaza.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:31:07 -0400
Message-Id: <1155929467.2924.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 18:10 +0200, Raphael Hertzog wrote:
> With the 2.6.17.7 kernel (configured with CONFIG_PREEMPT and
> CONFIG_HZ=1000), I'm seeing overruns starting at 38400 bauds. So
> compared to plain 2.4, it's better. However compared to the patched
> 2.4, it's worse.
> 

(Sorry for hijacking your thread)

Have you tried it with HZ=100?  HZ=1000 might just be too much for that
board.

Lee

