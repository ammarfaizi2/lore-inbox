Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTGCNBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTGCNBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:01:30 -0400
Received: from zork.zork.net ([64.81.246.102]:52641 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262288AbTGCNB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:01:29 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: o1-interactivity.patch (was Re: 2.5.74-mm1)
References: <20030703023714.55d13934.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Date: Thu, 03 Jul 2003 14:15:51 +0100
In-Reply-To: <20030703023714.55d13934.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 3 Jul 2003 02:37:14 -0700")
Message-ID: <6u65mjkayg.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> . Included Con's CPU scheduler changes.  Feedback on the effectiveness of
>   this and the usual benchmarks would be interesting.

I find that this patch makes X really choppy when Mozilla Firebird is
loading a page (which it does through an ssh tunnel here).  Both the X
pointer and the spinner in the tab that is loading stop and start, for
up to a second at a time.

