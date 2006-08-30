Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWH3UNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWH3UNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWH3UNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:13:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751475AbWH3UNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:13:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060830124400.23ca9b38.akpm@osdl.org> 
References: <20060830124400.23ca9b38.akpm@osdl.org>  <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] BLOCK: Make it possible to disable the block layer [try #6] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 21:13:12 +0100
Message-ID: <26780.1156968792@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I think I'll just slam all this in at the first opportunity.  Stuff will
> break, but it will be easy to fix.

Well, it's into Jens's block GIT tree.

> If you try to upissue this patchset I shall be seeking an IP-routable hand
> grenade.

"upissue"?

> This function is misnamed and is implemented in the wrong place.  It's not
> really a block thing at all.  If/when/soon NFS starts to implement it and
> call it, things will need to be renamed and reshuffled.

Sounds this function then migrate to kernel/sched.c along with its baggage
train.

> So...  for now, I'll replace it with a simple io_schedule_timeout(timeout),
> which is equivalent to what we do now for network filesystems.

Please send the patch to Jens to make sure the block GIT tree gets fixed.

David
