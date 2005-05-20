Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVETQrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVETQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVETQrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:47:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51094 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261482AbVETQrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:47:05 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Lee Revell <rlrevell@joe-job.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Ben Greear <greearb@candelatech.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
In-Reply-To: <428DAD71.4050105@aitel.hist.no>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
	 <428CCD19.6030909@candelatech.com>  <428DAD71.4050105@aitel.hist.no>
Content-Type: text/plain
Date: Fri, 20 May 2005 12:47:03 -0400
Message-Id: <1116607623.28552.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 11:27 +0200, Helge Hafting wrote:
> Ben Greear wrote:
> 
> > Arjan van de Ven wrote:
> >
> >> HZ may not exist. At all; people are trying to remove it. And userspace
> >> has no business knowing about it either.
> >
> >
> > It can be helpful to know what HZ you are running at, for instance if 
> > you care
> > very much about the (average) precision of a select/poll timeout.
> >
> Will  knowing it help?  You may find out that you don't have much precision,
> but then theres nothing to do about it.

Yes, it will.  If you have an RT constraint and 10ms won't cut it (say,
you want to send MIDI clock) then you can use the RTC.

Lee

