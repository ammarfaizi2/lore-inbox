Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbTHLMFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270228AbTHLMFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:05:16 -0400
Received: from hugin.diku.dk ([130.225.96.144]:59665 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id S270214AbTHLMFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:05:13 -0400
Date: Tue, 12 Aug 2003 14:05:11 +0200 (MEST)
From: "Peter \"Firefly\" Lund" <firefly@diku.dk>
To: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
In-Reply-To: <A98078D7EF5BEA4D8D8FD797FFBBC75F0453FCEA@fmsmsx402.fm.intel.com>
Message-ID: <Pine.LNX.4.55.0308121403160.16518@brok.diku.dk>
References: <A98078D7EF5BEA4D8D8FD797FFBBC75F0453FCEA@fmsmsx402.fm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Sottek, Matthew J wrote:

>    if(foo)
>      DEBUG_PRINT("Foo!\n");
>
> works great for 100 years until someone recodes the DEBUG_PRINT
> macro to be 2 lines.

Then those "someone" shouldn't be allowed near a macro system.

This is the standard trick:

#define DEBUG_PRINT(x) do { \
   stmt1; \
   stmt2; \
 } while (0)

-Peter
