Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVBHWdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVBHWdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVBHWcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:32:51 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:29919 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261593AbVBHWbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:31:08 -0500
Date: Tue, 8 Feb 2005 08:53:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: linux-kernel@vger.kernel.org, rufus-kernel@hackish.org
Subject: Re: [PATCH] hot-swapping support for PSX controllers
Message-ID: <20050208075316.GA2045@ucw.cz>
References: <42050EC2.3020402@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42050EC2.3020402@tremplin-utc.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 07:21:54PM +0100, Eric Piel wrote:
> Hello,
> 
> For now, a bug in the PSX controllers support in gamecon prevents 
> hot-swapping of such controllers. If a controllers is removed then all 
> the controllers stop working and cpu usage gets high. The attached patch 
> (against 2.6.11-rc3) corrects this bug by checking the information read 
> from the controller. If the message length is bigger than the maximum 
> possible, then it means the controller is not there and therefore this 
> value should be discarded.
> 
> Note that this is a re-send of a previous patch now that the patch of 
> Peter (which had to be applied before this one) has been intregrated in 
> the vanilla kernel. It's Peter's version modified to apply cleanly 
> against 2.6.11-rc3 plus a fix in the comment.
> 
> Please apply,
> Eric
> 
> --
> Fixes hotplug support for PSX controllers and some mis-sized arrays.
> 
> Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
> Signed-off-by: Peter Nelson <rufus-kernel@hackish.org>
> --

Thanks; applied.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
