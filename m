Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUKSGC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUKSGC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 01:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUKSGC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 01:02:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6016 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261264AbUKSGCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 01:02:19 -0500
Date: Fri, 19 Nov 2004 15:59:37 +1100
From: Nathan Scott <nathans@sgi.com>
To: Brad Fitzpatrick <brad@danga.com>
Cc: linux-kernel@vger.kernel.org, Lisa Phillips <lisa@danga.com>,
       Mark Smith <marksmith@danga.com>, linux-xfs@oss.sgi.com
Subject: Re: 2.6.9: unkillable processes during heavy IO
Message-ID: <20041119045937.GE1269@frodo>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com> <Pine.LNX.4.58.0411160549070.7904@danga.com> <20041116200156.2b2526e5.akpm@osdl.org> <20041117045506.GA1802@frodo> <Pine.LNX.4.58.0411162251170.7904@danga.com> <20041118050501.GD9834@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118050501.GD9834@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 04:05:01PM +1100, Nathan Scott wrote:
> I've reproduced it now with this tool and a simplified version
> of your recipe - I'll have a fix for you to try before too long.

Looks like a lock order problem - I have an experimental fix,
I'll send it to you shortly.

thanks.

-- 
Nathan
