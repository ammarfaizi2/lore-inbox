Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbUKQD7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUKQD7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbUKQD7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:59:36 -0500
Received: from siaag2ag.compuserve.com ([149.174.40.140]:23523 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S262157AbUKQD7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:59:34 -0500
Date: Tue, 16 Nov 2004 22:54:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411162259_MC3-1-8ED8-6C32@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 at 02:00:20 +0100, Andi Kleen wrote:

> On Mon, Nov 15, 2004 at 11:15:51PM -0500, Chuck Ebbert wrote:
> > Andrea posted this one-liner a while ago as part of a larger patch.  He said
> > it fixed return of the wrong policy in some conditions.  Was this a valid fix?
>
> Yes it was.

  At least it wasn't dropped -- it's in -mm as part of
fix-for-mpol-mm-corruption-on-tmpfs, though it's unrelated to tmpfs.
(That patch contains three separate changes...)

  Should just this part, which changes '<' to '<=', be pushed upstream?


--Chuck Ebbert  16-Nov-04  22:54:02
