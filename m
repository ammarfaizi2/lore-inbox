Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbTILVoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTILVoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:44:24 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35086
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261912AbTILVoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:44:23 -0400
Date: Fri, 12 Sep 2003 14:44:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: aa VM updates merged was: Linux 2.4.23-pre4
Message-ID: <20030912214429.GE30584@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 04:48:50PM -0300, Marcelo Tosatti wrote:
> And finally merge most important part of -aa VM. Those changes are fixing
> some OOM deadlocks, give us better per-zone balancing and better
> reclaiming. The OOM killer has been removed.
> 
> I've been using it on my 256MB desktop: performance feels much better, but 
> it needs extensive testing, so please help.

...

> <marcelo:logos.cnet>:
>   o aa VM merge: Per-zone watermark changes, add lower_zone_reserve_ratio
>   o aa VM merge: page reclaiming logic changes: Kills oom killer
>   o aa VM merge: Page accounting helpers changes
>   o aa VM merge: tunables
>   o aa VM merge: Kill PF_MEMDIE
>   o aa VM merge: Fixup page reclaiming changes patch

Great.  I will be going back to 2.4 to help test this for you.

Now we await the flamewar about removing the OOM killer... :-/
