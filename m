Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWEGSTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWEGSTD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 14:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWEGSTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 14:19:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57258 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750714AbWEGSTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 14:19:01 -0400
Subject: Re: snd_hda_intel on 2.6.16 (or higher)
From: Lee Revell <rlrevell@joe-job.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060426224924.M44901@linuxwireless.org>
References: <20060426224924.M44901@linuxwireless.org>
Content-Type: text/plain
Date: Sun, 07 May 2006 14:18:57 -0400
Message-Id: <1147025938.15364.263.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 16:55 -0600, Alejandro Bonilla wrote:
> Hi,
> 
> I reported some snd_hda_intel problem a month ago. I have been using 2.6.15-21
> perfectly, but with 2.6.16 or even git 2.6.17-rc2 it is still going like at
> 1.2x the speed it should go (1x is ok). You can notice Music will actually go
> faster and it may sometimes chipmonk.
> 
> Please let me know what exact info is required if interested. This is on a
> Compaq V2000 Ubuntu Dapper Drake up to date and with 2.6.15-X it has worked
> perfectly and still is, until 2.6.16 or higher is loaded.
> 

First, test the latest ALSA version (the one in the kernel lags behind
by a month or so).  Then please do a bisection to identify the exact
change that broke it.

Lee

