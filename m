Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbSLDQFN>; Wed, 4 Dec 2002 11:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbSLDQFN>; Wed, 4 Dec 2002 11:05:13 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44042
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266848AbSLDQFM>; Wed, 4 Dec 2002 11:05:12 -0500
Subject: Re: [PATCH] deprecate use of bdflush()
From: Robert Love <rml@tech9.net>
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021204131024.GA3428@neljae>
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com>
	 <1038935401.994.9.camel@phantasy>  <20021204131024.GA3428@neljae>
Content-Type: text/plain
Organization: 
Message-Id: <1039018361.1505.7.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Dec 2002 11:12:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 08:10, Daniel Kobras wrote:

> > Bdflush the user-space daemon went away a long time ago, ~1995.
> 
> sys_bdflush() is still usable in 2.4 to tune kupdated's parameters.
> Only func==1 functionality is long gone.

Right.  But the bdflush daemon was gone in 2.4.

> > Besides, you only see the message once for each daemon that is loaded. 
> > So regardless of the rate limiting you probably only see it once on
> > boot.
> 
> And each time you try to twist the flushing parameters.

There are no flushing parameters in 2.5, and this is a patch for 2.5.

	Robert Love

