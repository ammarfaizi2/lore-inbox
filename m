Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbULTCZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbULTCZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbULTCZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:25:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1043 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261391AbULTCZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:25:07 -0500
Date: Mon, 20 Dec 2004 03:25:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dan Dennedy <dan@dennedy.org>
Cc: Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220022503.GT21288@stusta.de>
References: <20041220015320.GO21288@stusta.de> <1103508610.3724.69.camel@kino.dennedy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103508610.3724.69.camel@kino.dennedy.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 09:10:10PM -0500, Dan Dennedy wrote:
> On Mon, 2004-12-20 at 02:53 +0100, Adrian Bunk wrote:
> > The patch below removes 41 unneeded EXPORT_SYMBOL's.
> 
> Unneeded according to whom, just you? These functions are part of an
> API. How do I know someone is not using these in a custom ieee1394
> kernel module in some industrial or research setting or something new
> under development to be contributed to linux1394 project?

If someone uses some of them in code to be contributed to the linux1394 
project, re-adding the EXPORT_SYMBOL's in question is trivial.

If someone uses some of them in a custom setting, re-adding them is 
trivial, too.

If the only user of one or more of these EXPORT_SYMBOL's was a non-free 
module, it's kernel policy that the EXPORT_SYMBOL's in question have to 
be removed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

