Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVE3Tot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVE3Tot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVE3TmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:42:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11277 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261721AbVE3Tli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:41:38 -0400
Date: Mon, 30 May 2005 21:41:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] security/: possible cleanups
Message-ID: <20050530194131.GL10441@stusta.de>
References: <20050516210815.GW27549@shell0.pdx.osdl.net> <20050516184501.GD5112@stusta.de> <17465.1116338881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17465.1116338881@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 03:08:01PM +0100, David Howells wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> 
> > I see no issue with the keys changes, except I'd rather see key_duplicate
> > removed entirely if it's not getting used.  David, is there a plan to
> > put it to use, or can Adrian remove it?
> 
> There was a keyctl call for it, I thought. I wonder what happened to it. Let
> me think about what I want to do with it. Note that if key_duplicate() gets
> removed, then the key_type->duplicate() op may as well be rooted out and shot
> too.

Have you thought about what to do with key_duplicate()?

> The rest of the patch looks vaguely okay.
> 
> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

