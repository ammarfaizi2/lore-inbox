Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVHQCJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVHQCJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 22:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHQCJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 22:09:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17080 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750799AbVHQCJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 22:09:44 -0400
Subject: Re: [rfc][patch] API for timer hooks
From: Lee Revell <rlrevell@joe-job.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43024ADA.8030508@aknet.ru>
References: <42FDF744.2070205@aknet.ru>
	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 22:09:39 -0400
Message-Id: <1124244580.30036.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 00:21 +0400, Stas Sergeev wrote:
> 1. It needs the higher interrupt frequency.
> Since there seem to be no API to change
> the timer frequency at runtime, the driver
> does this itself. Now I have googled out
> the thread 

Wow, your driver implements bass and treble controls by varying the
frequency of the timer interrupt.  That's a neat hack, but I'd expect it
to raise a few eyebrows if it's submitted for mainline...

Lee

