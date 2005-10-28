Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVJ1TqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVJ1TqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVJ1TqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:46:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15006 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030300AbVJ1TqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:46:19 -0400
Date: Sat, 29 Oct 2005 05:46:18 +1000
From: Nathan Scott <nathans@sgi.com>
To: AndyLiebman@aol.com
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: What happened to XFS Quota Support?
Message-ID: <20051029054618.A6139565@wobbly.melbourne.sgi.com>
References: <190.4ba4a2cb.3093d02a@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <190.4ba4a2cb.3093d02a@aol.com>; from AndyLiebman@aol.com on Fri, Oct 28, 2005 at 03:04:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Oct 28, 2005 at 03:04:10PM -0400, AndyLiebman@aol.com wrote:
> ...
> Is there a reason why this option is no longer available? If you compile  
> xfs_quota as a module, how do you load it? 

Oh, bother - the option:

config XFS_QUOTA
        tristate "XFS Quota support"

should be:

config XFS_QUOTA
	bool "XFS Quota support"

I'll get that fixed up, thanks.

-- 
Nathan
