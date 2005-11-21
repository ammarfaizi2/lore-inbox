Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVKUUl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVKUUl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVKUUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:41:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932459AbVKUUly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:41:54 -0500
Date: Mon, 21 Nov 2005 12:41:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: tiwai@suse.de, rmk+lkml@arm.linux.org.uk, wli@holomorphy.com,
       davem@davemloft.net, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       airlied@gmail.com, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/11] unpaged: fix sound Bad page states
Message-Id: <20051121124105.1bf8090d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>   arch/sparc/kernel/ioport.c |    2 +-
>   arch/sparc64/kernel/sbus.c |    2 +-
>   sound/core/memalloc.c      |    2 ++
>   3 files changed, 4 insertions(+), 2 deletions(-)

So with this, do you think everything is in place for a mainline merge?
