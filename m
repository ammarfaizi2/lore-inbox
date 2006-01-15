Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWAOVLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWAOVLf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWAOVLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:11:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7060 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750802AbWAOVLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:11:34 -0500
Date: Mon, 16 Jan 2006 08:11:26 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6: xfs is rebuilt on every .config change
Message-ID: <20060116081126.C8430989@wobbly.melbourne.sgi.com>
References: <200601151226.49461.arvidjaar@mail.ru> <20060115095410.GA8195@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060115095410.GA8195@mars.ravnborg.org>; from sam@ravnborg.org on Sun, Jan 15, 2006 at 10:54:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 10:54:10AM +0100, Sam Ravnborg wrote:
> On Sun, Jan 15, 2006 at 12:26:46PM +0300, Andrey Borzenkov wrote:
> > - - xfs is rebuilt. This happens when there are *no* changes related to xfs 
> > alltogether. E.g. I now applied 2.6.15.1 patch and xfs got rebuilt again.
> 
> The xfs source files do:
> #include <version.h>
> To gain access to actual kernel release.
> 
> So each time you do a change to the tree that causes version.h to be
> updated the xfs source files will be recompiled.

We really don't need that in mainline - I'll clean this up shortly.

thanks.

-- 
Nathan
