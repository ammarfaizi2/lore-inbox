Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVHEQBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVHEQBB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVHEP6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:58:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65433 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262296AbVHEP4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:56:36 -0400
Date: Fri, 5 Aug 2005 17:58:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       prasadav@us.ibm.com
Subject: Re: [-mm patch] relayfs: add read() support
Message-ID: <20050805155826.GT5561@suse.de>
References: <17138.53203.430849.147593@tut.ibm.com> <20050805144926.GS5561@suse.de> <17139.32831.571021.34524@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17139.32831.571021.34524@tut.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05 2005, Tom Zanussi wrote:
> Jens Axboe writes:
>  > On Thu, Aug 04 2005, Tom Zanussi wrote:
>  > > At the kernel summit, there was some discussion of relayfs and the
>  > > consensus was that it didn't make sense for relayfs to not implement
>  > > read().  So here's a read implementation...
>  > 
>  > It needs a few fixes to actually compile without errors. This works for
>  > me, just tested with the block tracing stuff, works a charm!
> 
> Great, glad to hear it!  I should have noted in the posting, though,
> that you should first apply the 'API cleanup' patch, in which case you
> shouldn't get the compile errors.

Ah, I see. The API is also much cleaner than what I looked at a few
months ago (even before the cleanup).

Andrew, can you merge it pretty please?

-- 
Jens Axboe

