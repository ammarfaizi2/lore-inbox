Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVHYE6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVHYE6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVHYE6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:58:37 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:18721 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S964799AbVHYE6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:58:36 -0400
Date: Thu, 25 Aug 2005 07:00:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
Message-ID: <20050825050009.GA8247@mars.ravnborg.org>
References: <200508242108.53198.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508242108.53198.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 09:08:53PM +0200, Jesper Juhl wrote:
> Convert strtok() use to strsep() in usr/gen_init_cpio.c
> 
> I've compile tested this patch and it compiles fine.
> I build a 2.6.13-rc6-mm2 kernel with the patch applied without problems, and
> the resulting kernel boots and runs just fine (using it right now).
> But despite this basic testing it would still be nice if someone would 
> double-check that I haven't made some silly mistake that would break some 
> other setup than mine.
This is userland - I see no point in uglyfying the code.

	Sam
