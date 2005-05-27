Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVE0Nvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVE0Nvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0Nvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:51:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1233 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261438AbVE0Nvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:51:39 -0400
Subject: Re: weird X problem - priority inversion?
From: Lee Revell <rlrevell@joe-job.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz>
References: <1113428938.16635.13.camel@mindpipe>
	 <20050523075508.GC9287@elte.hu>
	 <Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Date: Fri, 27 May 2005 09:51:38 -0400
Message-Id: <1117201898.13829.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 01:11 -0700, David Lang wrote:
> remember that the low pri screensaver is just generating the image to be 
> displayed, it's the high pri X server that's actually doing the work to 
> display it.
> 

Understood.   It still seems like a bug that a lowly screensaver can
wedge the X server to the point that it consumes all available CPU.
This is a DoS - you can barely ssh in.

Lee

