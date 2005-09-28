Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVI1AbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVI1AbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVI1AbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:31:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbVI1AbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:31:17 -0400
Date: Tue, 27 Sep 2005 17:30:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nate Diller <nate@namesys.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] block cleanups: Add kconfig default iosched submenu
Message-Id: <20050927173026.537e3022.akpm@osdl.org>
In-Reply-To: <4339E2DD.5000202@namesys.com>
References: <4339C597.3070409@namesys.com>
	<20050927224121.GK2811@suse.de>
	<4339E2DD.5000202@namesys.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller <nate@namesys.com> wrote:
>
> Jens Axboe wrote:
> > On Tue, Sep 27 2005, Nate Diller wrote:
> > 
> >>Add a kconfig submenu to select the default I/O scheduler, in case 
> >>anticipatory is not compiled in or another default is preferred.  Also, 
> >>since no-op is always available, we should use it whenever the selected 
> >>default is not.
> >>
> >>I saw a patch recently to add this option, and I don't think it got picked 
> >>up.  This version is cleaner, since it eliminates all the #ifdef's in the 
> >>code itself.
> > 
> > 
> > Can you rebase this against latest -mm, it has the other patch you
> > mentioned applied (in a more cleaned up version)? Thanks.
> > 
> The latest -mm on kernel.org seems to be 2.6.14-rc2-mm1, and the other patch does not seem to be 
> included in that.  Is there a git tree I should be patching against?
> 

I'll sort it out.
