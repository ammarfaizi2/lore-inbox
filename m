Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUJYLPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUJYLPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUJYLP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:15:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40130 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261762AbUJYLPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:15:19 -0400
Date: Mon, 25 Oct 2004 13:15:17 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Quota warnings somewhat broken
Message-ID: <20041025111517.GF13208@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr> <20041022093423.GC31932@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 22 Oct 2004, Jan Kara wrote:
> >
> >   Thanks for notifying. It looks like a good idea. Attached patch should apply
> > well to 2.6.9. Linus, please apply.
> 
> Why does this code use tty_write_message() in the first place? It's a bit 
> rude to mess up the users tty without any way to disable it, isn't it? 
  OK, I'll tide up a bit a patch of Jan Engelhardt <jengelh@linux01.gwdg.de>
and send it to you.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
