Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWIVNxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWIVNxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWIVNxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:53:55 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:9289 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932485AbWIVNxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:53:54 -0400
Date: Fri, 22 Sep 2006 15:53:53 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: dbtsai@gmail.com, John Linville <linville@tuxdriver.com>,
       netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bcm43xx softMac Driver in 2.6.18
Message-ID: <20060922135352.GD4122@harddisk-recovery.com>
References: <4513E308.10507@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4513E308.10507@lwfinger.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 08:20:08AM -0500, Larry Finger wrote:
> This patch, which was originally sent to John Linville on 9/14/06,
> has been taken against 2.6.18. It changes more lines
> than would be absolutely necessary to affect the fix; however, it
> ends up with this section looking exactly like the current code (with
> pending patches) that is in wireless-2.6.

Sorry, but your patch doesn't apply cleanly against 2.6.18:

erik@arthur:~/git/linux-2.6 > patch -p1 --dry-run < ../bcm43xx-2.6.18.diff
patching file drivers/net/wireless/bcm43xx/bcm43xx_main.c
Hunk #1 FAILED at 3182.
1 out of 1 hunk FAILED -- saving rejects to file drivers/net/wireless/bcm43xx/bcm43xx_main.c.rej


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
