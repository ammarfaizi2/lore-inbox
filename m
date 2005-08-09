Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVHIO73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVHIO73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVHIO73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:59:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19363 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964814AbVHIO72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:59:28 -0400
Subject: Re: Soft lockup in e100 driver ?
From: Lee Revell <rlrevell@joe-job.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050809133647.GK22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 10:58:42 -0400
Message-Id: <1123599524.30101.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 16:36 +0300, Matti Aarnio wrote:
> Running very recent Fedora Core Development kernel I can following
> soft-oops..   ( 2.6.12-1.1455_FC5smp )
> 
> 
> e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
> BUG: soft lockup detected on CPU#0!

Could this be a false positive?  It's suspicious that the soft lockup
detector was just merged to mainline then you got this.

Lee

