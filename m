Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWEPTj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEPTj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWEPTj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:39:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41993 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750716AbWEPTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:39:58 -0400
Date: Tue, 16 May 2006 21:39:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-ID: <20060516193956.GS10077@stusta.de>
References: <20060516174413.GI10077@stusta.de> <20060516122731.6ecbdeeb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516122731.6ecbdeeb.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 12:27:31PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > - remove the following unused EXPORT_SYMBOL's:
> >   - journal_set_features
> >   - journal_update_superblock
> 
> These might be used by lustre - dunno.

I don't see this.

> But I'm ducking all patches which alter exports, as usual.  If you can get
> them through the subsystem maintainer then good luck.
>...

Since you replied to this patch:
Who is the subsystem maintainer for jbd?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

