Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHRRQn>; Sun, 18 Aug 2002 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSHRRQn>; Sun, 18 Aug 2002 13:16:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4622
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315427AbSHRRQm>; Sun, 18 Aug 2002 13:16:42 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Robert Love <rml@tech9.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020818171831.GT21643@waste.org>
References: <20020818021522.GA21643@waste.org>
	<Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com>
	<20020818042818.GG21643@waste.org> <1029689668.903.19.camel@phantasy> 
	<20020818171831.GT21643@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 13:20:41 -0400
Message-Id: <1029691241.903.40.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 13:18, Oliver Xymoron wrote:

> I'm thinking of changing urandom read to avoid pulling entropy from
> the primary pool (via xfer) if it falls below a given low
> watermark. The important part is to prevent starvation of
> /dev/random, it doesn't have to be fair.

A watermark (perhaps /proc configurable) is a very sane way of doing
this.  Great.

> My patches should provide sufficient entropy for any workstation use
> with or without network sampling. It's only the headless case that's
> problematic - see my compromise patch with trust_pct.

Sounds good to me, so we shall see...

	Robert Love

