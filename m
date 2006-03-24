Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWCXPIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWCXPIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWCXPIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:08:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54534 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750901AbWCXPIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:08:37 -0500
Date: Fri, 24 Mar 2006 16:08:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tilman Schmidt <tilman@imap.cc>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i810 framebuffer - BUG: sleeping function called from invalid context
Message-ID: <20060324150835.GD22727@stusta.de>
References: <44186D30.4040603@imap.cc> <20060317031410.2479d8e1.akpm@osdl.org> <441ACCD5.6070404@pol.net> <441BEF7D.4000605@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441BEF7D.4000605@imap.cc>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 12:31:09PM +0100, Tilman Schmidt wrote:
> On 17.03.2006 15:51, Antonino A. Daplas wrote:
> > The console cursor can be called in atomic context.  Change memory
> > allocation to use the GFP_ATOMIC flag in i810fb_cursor().
> 
> Thanks, that fixed it.

Tony, this seems to be 2.6.16.1 material?
If yes, can you submit it for -stable?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

