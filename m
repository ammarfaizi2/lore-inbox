Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVCOR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVCOR2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVCOR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:27:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261543AbVCORZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:25:12 -0500
Date: Tue, 15 Mar 2005 18:25:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.co,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error
Message-ID: <20050315172508.GQ3189@stusta.de>
References: <20050315121930.GE3189@stusta.de> <20050315091305.3fc07561@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315091305.3fc07561@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 09:13:05AM -0800, Stephen Hemminger wrote:

> Given the #ifdef mess, perhaps bridge should have the hooks available
> independent of the configuration.

The problem is the other way round:
The bridge code accesses hooks in the ATM code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

