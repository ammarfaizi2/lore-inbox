Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbUA0AUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbUA0AUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:20:36 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:63678 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265713AbUA0AUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:20:30 -0500
Date: Tue, 27 Jan 2004 11:19:59 +1100
From: Nathan Scott <nathans@sgi.com>
To: Bryan Whitehead <driver@megahappy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2-rc1-mm3] fs/xfs/xfs_log_recover.c
Message-ID: <20040127001959.GG781@frodo>
References: <20040125044859.8A67F13A354@mrhankey.megahappy.net> <20040126234159.GD781@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126234159.GD781@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 10:41:59AM +1100, Nathan Scott wrote:
> On Sat, Jan 24, 2004 at 08:48:59PM -0800, Bryan Whitehead wrote:
> > On compile I get this:
> > 
> > fs/xfs/xfs_log_recover.c: In function `xlog_recover_reorder_trans':
> > fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function
> > 
> > I previously sent this patch and it was wrong.
> 
> What compiler version are you using?  Is this a recent gcc or an

Sorry, I'm still half a sleep -- I see this too with the recent
fix in this routine, looks like many current gcc versions report
it.  I guess initialising flags to zero will be the simplest way
to workaround it.

thanks.

-- 
Nathan
