Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUDBUqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbUDBUqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:46:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:36559 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264175AbUDBUqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:46:40 -0500
Message-Id: <200404022046.i32KkX231280@mail.osdl.org>
Date: Fri, 2 Apr 2004 12:46:30 -0800 (PST)
From: markw@osdl.org
Subject: Re: 2.6.5-rc3-mm4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040402115601.24912093.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Apr, Andrew Morton wrote:
> - I'm surprised that you didn't see big gains from ext3-fsync-speedup,
>   even though it appears that the test uses fdatasync().

Yeah, PostgreSQL defaults to fdatasync.  I should have paid closer
attention when you said *-fsync-speedup patches...  I'll rerun using
fsync.

PostgreSQL will also do open_sync.

Mark
