Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVK1Vvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVK1Vvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVK1Vvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:51:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30471 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751324AbVK1Vvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:51:44 -0500
Date: Mon, 28 Nov 2005 22:51:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       markus.lidel@shadowconnect.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mark Salyzyn <mark_salyzyn@adaptec.com>
Subject: Re: [patch] drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference
Message-ID: <20051128215143.GE31395@stusta.de>
References: <20051126233637.GC3988@stusta.de> <1133203032.3325.46.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133203032.3325.46.camel@mulgrave>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 12:37:11PM -0600, James Bottomley wrote:
> On Sun, 2005-11-27 at 00:36 +0100, Adrian Bunk wrote:
> > The Coverity checker spotted this obvious NULL pointer dereference.
> 
> It's a bit late for this one, since Linus already put it in, but for
> future reference, could you please try to use proper descriptions.  This
> isn't an "obvious NULL pointer dereference", it's actually a use after
> free of a data structure.

OK sorry, I'll look better at the descriptions for future patches.

> Thanks,
> 
> James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

