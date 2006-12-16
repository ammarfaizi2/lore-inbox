Return-Path: <linux-kernel-owner+w=401wt.eu-S1161369AbWLPTGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWLPTGq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 14:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161370AbWLPTGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 14:06:46 -0500
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:55236 "EHLO
	excu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161369AbWLPTGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 14:06:45 -0500
X-AuditID: c606310c-a0855bb0000072e7-51-45844614cdd1 
Date: Sat, 16 Dec 2006 19:07:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Martin Michlmayr <tbm@cyrius.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Jan Kara <jack@suse.cz>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org
Subject: Re: Recent mm changes leading to filesystem corruption?
In-Reply-To: <20061216184450.GA21129@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64.0612161903270.25272@blonde.wat.veritas.com>
References: <20061216155044.GA14681@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612161812090.21270@blonde.wat.veritas.com>
 <20061216184450.GA21129@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Dec 2006 19:06:44.0376 (UTC) FILETIME=[53AE9980:01C72145]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Martin Michlmayr wrote:
> * Hugh Dickins <hugh@veritas.com> [2006-12-16 18:20]:
> > Very disturbing.  I'm not aware of any problem with them, and we
> > surely wouldn't have released 2.6.19 with any known-corrupting patches
> > in.  There's some doubts about 2.6.19 itself in the links below: were
> > it not for those, I'd suspect a mismerge of the pieces into 2.6.18,
> > perhaps a hidden dependency on something else.  I'll ponder a little,
> > but let's CC linux-mm in case someone there has an idea.
> 
> Do you think http://article.gmane.org/gmane.linux.kernel/473710 might
> be related?

Sounds like it.  Let's CC Jan Kara on your other thread,
he seems to have delved into it a little.

Hugh
