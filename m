Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbULHFGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbULHFGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbULHFGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:06:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12985 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262019AbULHFGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:06:44 -0500
Date: Wed, 8 Dec 2004 16:03:48 +1100
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some XFS cleanups (fwd)
Message-ID: <20041208050348.GI1611@frodo>
References: <20041207193533.GG7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207193533.GG7250@stusta.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 08:35:33PM +0100, Adrian Bunk wrote:
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc2-mm4.
> 
> Please apply.

Needs a bit of tweaking yet...  (apologies for not replying
earlier, there's just been more pressing things to work on).

> ----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----
> 
> Date:	Sat, 30 Oct 2004 20:13:07 +0200
> From: Adrian Bunk <bunk@stusta.de>
> To: nathans@sgi.com
> Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
> Subject: [2.6 patch] some XFS cleanups
> 
> The patch below makes the following cleanups in the XFS code:
> - remove the unused global function vfs_dmapiops
> - remove some unused #define's

These first changes aren't really useful; they make the DMAPI
code more difficult to integrate and manage in our trees, for
not-enough gain.

> - make several functions static

These are more useful - I'll merge these in, thanks.

cheers.

-- 
Nathan
