Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVLBUlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVLBUlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVLBUlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:41:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:33955 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751132AbVLBUlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:41:02 -0500
Date: Fri, 2 Dec 2005 20:40:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051202194447.GA7679@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
References: <20051129092432.0f5742f0.akpm@osdl.org>
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
 <20051202180326.GB7634@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com>
 <20051202194447.GA7679@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Dec 2005 20:40:57.0682 (UTC) FILETIME=[B2C16320:01C5F780]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Ryan Richter wrote:
> 
> OK, I guess I'll stick with 2.6.14.3 for now, plus your patch.  Should I
> keep Kai's st.c patch?  There was some mention of other patches, are
> those relevant?  Most of that discussion went over my head...

For the "Bad page state" premature freeing you were seeing, only my
patch should be relevant.  There are other patches in the works, yes,
and we have good reasons for them; but don't worry about them for this.

Hugh
