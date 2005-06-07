Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVFGHoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVFGHoD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 03:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVFGHoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 03:44:03 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:6772 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261449AbVFGHoA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 03:44:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZiG5HDc6J5C6EjBxCzbpgDJXV4YjU2+VUouGDoylqa4mD+yMsOz5BV4c7Rw63tPaRlT/d8UfbBGgr/z4rpXLSltE/pXtzQTW2WpDXHhhXCWVdUaxmKUkbotxPkuf9xsUGAT7/BDBUZfC8ZluZiKRydhnUHsYg/+f0R9K53HRLIs=
Message-ID: <21d7e997050607004411bfa36b@mail.gmail.com>
Date: Tue, 7 Jun 2005 17:44:00 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: Linux v2.6.12-rc6
Cc: Voluspa <lista1@telia.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <2lhaa112u32htehrvnmqg6vh2kl8puesj8@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050607081116.65c10190.lista1@telia.com>
	 <20050607061831.GA6957@elte.hu>
	 <20050607083731.5edfd276.lista1@telia.com>
	 <2lhaa112u32htehrvnmqg6vh2kl8puesj8@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 7 Jun 2005 08:37:31 +0200, Voluspa <lista1@telia.com> wrote:
> >Ah, sorry about the noise... I've been away from kernel testing too
> >long. I patched a 2.6.11.11 tree without noticing all the rejects (this
> >new machine is fast). But from what I remember, it was decided to do
> >the -rc patches against the latest stable codebase, in this case .11
> >Shrug.
> I dunno what the change was, patch didn't apply cleanly to 2.6.11,
> (no idea if bad .bz2, finger trouble), so I download whole thing
> instead, now running on three x86 boxen.

It was explicitly stated by Linus way back 2.6.8.1 time that
subsequent patches are against the base of the previous release, so
-rcs are against 2.6.x not 2.6.x.y.. which all makes great sense if
development is happening in parallel... I'm not sure I've ever heard
anything else stated to oppose this, but apparently some people have..

Dave.
