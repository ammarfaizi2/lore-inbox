Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVHHUKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVHHUKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVHHUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:10:47 -0400
Received: from mail.suse.de ([195.135.220.2]:52406 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932203AbVHHUKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:10:47 -0400
Date: Mon, 8 Aug 2005 22:10:46 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add MODULE_ALIAS for x86_64 aes
Message-ID: <20050808201046.GB15425@suse.de>
References: <20050808173336.GA11503@suse.de> <20050808105109.5e3168fc.akpm@osdl.org> <20050808175520.GA12150@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050808175520.GA12150@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 08, Olaf Hering wrote:

>  On Mon, Aug 08, Andrew Morton wrote:
> 
> > Olaf Hering <olh@suse.de> wrote:
> > >
> > > 
> > > modprobe aes does not work on x86_64. i386 has a similar line,
> > > this could be the right fix. Would be nice to have in 2.6.13 final.
> > > 
> > 
> > What do you mean by "this could be the right fix"?  Did it work?
> 
> I cant test it due to lack of hardware. Will find someone who does.
> modprobe aes is done by openswan, works on ppc, i386, but not on x86_64.

This works, tested it. modprobe -v aes
insmod /lib/modules/2.6.13-rc6-3-default/kernel/arch/x86_64/crypto/aes-x86_64.ko 

