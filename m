Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUBBS0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUBBS0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:26:16 -0500
Received: from s4.uklinux.net ([80.84.72.14]:22409 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265802AbUBBS0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:26:11 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>
	<401DDCD7.3010902@cyberone.com.au>
From: Philip Martin <philip@codematters.co.uk>
Date: Mon, 02 Feb 2004 18:08:01 +0000
In-Reply-To: <401DDCD7.3010902@cyberone.com.au> (Nick Piggin's message of
 "Mon, 02 Feb 2004 16:15:03 +1100")
Message-ID: <877jz55p8e.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> Thats weird. It looks like 2.6 is being stalled on writeout.
> Are running on all local filesystems?

Yes.

> You said a non-RAID ext2 filesystem performed similarly?

Yes, the ext2 build was a little faster in terms of elapsed time, but
it used the same amount of CPU as the RAID/ReiserFS build.

-- 
Philip Martin
