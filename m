Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWA1Bmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWA1Bmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422783AbWA1Bmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:42:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50148 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422762AbWA1Bmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:42:55 -0500
Subject: Re: 25ms latency for msleep() and NAPI rx_schedule()/poll()
From: Lee Revell <rlrevell@joe-job.com>
To: betonava@earthlink.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <28705905.1138411758814.JavaMail.root@elwamui-sweet.atl.sa.earthlink.net>
References: <28705905.1138411758814.JavaMail.root@elwamui-sweet.atl.sa.earthlink.net>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 20:42:48 -0500
Message-Id: <1138412568.7572.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 17:29 -0800, betonava@earthlink.net wrote:
>  Hi,
> 
> After migrating from 2.6.12 to 2.6.13/2.6.14 we have started seeing sporadic ~25ms scheduling delays after a process is woken up from a msleep(), and ~25ms latency for a NAPI rx_schedule()/poll()  to be schedule.

Set CONFIG_HZ to 1000 on 2.6.13 and later, otherwise you are comparing
apples to oranges.

Lee

