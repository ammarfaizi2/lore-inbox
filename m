Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUEULwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUEULwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUEULwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:52:09 -0400
Received: from gprs214-11.eurotel.cz ([160.218.214.11]:52096 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265590AbUEULwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:52:03 -0400
Date: Fri, 21 May 2004 13:51:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040521115141.GD10052@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521111828.GA870@gondor.apana.org.au> <20040521112209.GA951@gondor.apana.org.au> <20040521114125.GA10052@elf.ucw.cz> <20040521114813.GA1204@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521114813.GA1204@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I guess that open-coding #if defined() || defined() is right thing to
> > do for now.
> > 
> > Suspend2 when/if merged might not need this... This one is not really
> > specific to suspend-to-disk. It is specific to swsusp way of doing
> > things, which happens to be same as pmdisk way of doing it...
> 
> Well that symbol would not apply to just this case.  We can also use
> it for arch/i386/power/cpu.c itself.  It appears to be used solely for
> the purpose of suspending to disk.

Well, all those symbols might get pretty confusing, but I guess we can
live with that.
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
