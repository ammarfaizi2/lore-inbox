Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUA0AKS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUA0AKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:10:18 -0500
Received: from s383.jpl.nasa.gov ([137.79.94.127]:24564 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S265686AbUA0AKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:10:12 -0500
Message-ID: <4015AC20.5060704@megahappy.net>
Date: Mon, 26 Jan 2004 16:09:04 -0800
From: Bryan Whitehead <driver@megahappy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw, ja
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Bryan Whitehead <driver@megahappy.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2-rc1-mm3] fs/xfs/xfs_log_recover.c
References: <20040125044859.8A67F13A354@mrhankey.megahappy.net> <20040126234159.GD781@frodo>
In-Reply-To: <20040126234159.GD781@frodo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Sat, Jan 24, 2004 at 08:48:59PM -0800, Bryan Whitehead wrote:
> 
>>On compile I get this:
>>
>>fs/xfs/xfs_log_recover.c: In function `xlog_recover_reorder_trans':
>>fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function
>>
>>I previously sent this patch and it was wrong.
> 
> 
> What compiler version are you using?  Is this a recent gcc or an
> older version - if the former, is gcc really getting dumber?  if
> the latter, I'm wondering why I haven't come across this anytime
> in the last few years of compiling xfs.  Or is this some non-gcc
> compiler out of left field?
> 
> thanks.
> 

This is gcc 3.3.2 on gentoo linux.

gcc may be getting dumber, or just more precautious?

-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov

