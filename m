Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVHRPWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVHRPWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVHRPWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:22:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9389 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932245AbVHRPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:22:37 -0400
Subject: Re: [xfs-masters] Re: [PATCH] pull XFS support out of Kconfig
	submenu
From: Russell Cattelan <cattelan@thebarn.com>
To: xfs-masters@oss.sgi.com
Cc: Jesper Juhl <jesper.juhl@gmail.com>, nathans@sgi.com,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050818135356.GA16845@taniwha.stupidest.org>
References: <200508172245.49043.jesper.juhl@gmail.com>
	 <20050818135356.GA16845@taniwha.stupidest.org>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 10:22:26 -0500
Message-Id: <1124378546.25069.107.camel@naboo.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-4mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 06:53 -0700, Chris Wedgwood wrote:
> On Wed, Aug 17, 2005 at 10:45:48PM +0200, Jesper Juhl wrote:
> 
> > It seems slightly odd to me that XFS support should be in a separate
> > submenu, when all the other filesystems are not using submenus but
> > are directly selectable from the Filesystems menu.
> 
> XFS also has an out-of-tree version.  Making it a submenu is probably
> to make maintenance easier (ie. replace files, not merge).
> 
That is why the Kconfig options for xfs moved from fs/Kconfig to
fs/xfs/Kconfig but using submenu was simply a convince thing 
to group all the XFS options together.

If the submenu is really causing people distress go ahead and 
remove it. Since it's a cosmetic change it's not going to impact
anything.

-Russell

