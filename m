Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSLCRPk>; Tue, 3 Dec 2002 12:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSLCRPk>; Tue, 3 Dec 2002 12:15:40 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4368
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261894AbSLCRPj>; Tue, 3 Dec 2002 12:15:39 -0500
Subject: Re: [PATCH] deprecate use of bdflush()
From: Robert Love <rml@tech9.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038935401.994.9.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-3) 
Date: 03 Dec 2002 12:10:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 09:24, Bill Davidsen wrote:

> My take on this is that it's premature. This would be fine in the 2.6.0-rc
> series, but the truth is that the majority of 2.5 users boot 2.5 for
> testing but run 2.4 for normal use. They aren't going to get rid of
> bdflush and this just craps up the logs. At least with the occurrence
> limit it will only happen a few times. I would like to see it once only,
> myself, as a reminder rather than a nag.

2.4 does not need bdflush, either.

Bdflush the user-space daemon went away a long time ago, ~1995.

Besides, you only see the message once for each daemon that is loaded. 
So regardless of the rate limiting you probably only see it once on
boot.

	Robert Love

