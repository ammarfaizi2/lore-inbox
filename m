Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbULHTi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbULHTi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbULHTi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:38:28 -0500
Received: from holomorphy.com ([207.189.100.168]:7917 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261331AbULHTf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:35:29 -0500
Date: Wed, 8 Dec 2004 11:35:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limiting program swap
Message-ID: <20041208193524.GU2714@holomorphy.com>
References: <cp7iqj$57n$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cp7iqj$57n$1@gatekeeper.tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:07:36PM -0500, Bill Davidsen wrote:
> I have several machine of various memory sizes which suffer from really 
> poor performance when doing backups. This appears to be because all the 
> programs other than the backup quickly get swapped to make room for i/o 
> buffers.
> Is there some standard portable way to prevent this, either by reserving 
> some memory for programs which will not get swapped regardless of i/o 
> pressure, or alternatively limiting the total memory used for i/o 
> buffers, dcache, and similar things?
> I did a crude hack for 2.4.17, but if I'm missing some obvious trick I'd 
> rather not do something which can't go in the mainline kernel. Anyone 
> care to show me what I missed, or is this just a characteristic of Linux?

This appears at least superficially related to
/proc/sys/vm/vfs_cache_pressure in 2.6.x-mm (possibly also mainline)


-- wli
