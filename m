Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJHVt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJHVt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUJHVt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:49:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52444 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265697AbUJHVtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:49:22 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20041008144539.K2357@build.pdx.osdl.net>
References: <87pt43clzh.fsf@sulphur.joq.us>
	 <20040930182053.B1973@build.pdx.osdl.net> <87k6ubcccl.fsf@sulphur.joq.us>
	 <1096663225.27818.12.camel@krustophenia.net>
	 <20041001142259.I1924@build.pdx.osdl.net>
	 <1096669179.27818.29.camel@krustophenia.net>
	 <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us>
	 <1097193102.9372.25.camel@krustophenia.net>
	 <1097269108.1442.53.camel@krustophenia.net>
	 <20041008144539.K2357@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1097272140.1442.75.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 17:49:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 17:45, Chris Wright wrote:
> > --- linux-2.6.8.1/security/realtime.c	Wed Dec 31 18:00:00 1969
> > +++ linux-2.6.8.1-rt02/security/realtime.c	Mon Oct  4 21:35:41 2004
> > +static int any = 0;			/* if TRUE, any process is realtime */
> 
> unecessary init to 0
> 

I think gcc 3.4 complains otherwise.

Lee

