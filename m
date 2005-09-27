Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbVI0Wk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbVI0Wk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbVI0Wk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:40:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965217AbVI0Wk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:40:57 -0400
Date: Wed, 28 Sep 2005 00:41:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate@namesys.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] block cleanups: Add kconfig default iosched submenu
Message-ID: <20050927224121.GK2811@suse.de>
References: <4339C597.3070409@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4339C597.3070409@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27 2005, Nate Diller wrote:
> Add a kconfig submenu to select the default I/O scheduler, in case 
> anticipatory is not compiled in or another default is preferred.  Also, 
> since no-op is always available, we should use it whenever the selected 
> default is not.
> 
> I saw a patch recently to add this option, and I don't think it got picked 
> up.  This version is cleaner, since it eliminates all the #ifdef's in the 
> code itself.

Can you rebase this against latest -mm, it has the other patch you
mentioned applied (in a more cleaned up version)? Thanks.

-- 
Jens Axboe

