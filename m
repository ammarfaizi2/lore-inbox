Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUHFAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUHFAPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUHFAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:15:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24301 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267454AbUHFAPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:15:37 -0400
Date: Fri, 6 Aug 2004 11:10:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: L A Walsh <lkml@tlinx.org>, Helge Hafting <helge.hafting@hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040806011059.GA774@frodo>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org> <20040729013049.GE800@frodo> <410FDA19.9020805@tlinx.org> <4111ECC2.4040301@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4111ECC2.4040301@hist.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:16:02AM +0200, Helge Hafting wrote:
> L A Walsh wrote:
> >Now I know it takes a while before data may end up on disk and that it
> >may not go out to disk in an ordered fashion, but 2-3 days?  
> 
> Seems strange to me, but the amount of delay is entirely up to the 
> filesystem.

The flushing of dirty file data is actually performed by
kernel threads outside of the individual filesystems.

I cannot explain a 2/3 day wait for data to get flushed,
something really strange going on for you there.

cheers.

-- 
Nathan
