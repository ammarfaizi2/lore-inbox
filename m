Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWH0Uyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWH0Uyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWH0Uyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:54:54 -0400
Received: from mail.suse.de ([195.135.220.2]:24555 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932231AbWH0Uyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:54:53 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Date: Sun, 27 Aug 2006 22:54:13 +0200
User-Agent: KMail/1.9.3
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com>
In-Reply-To: <44F1F356.5030105@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272254.13871.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 21:32, H. Peter Anvin wrote:
> Andi Kleen wrote:
> > 
> > Just increasing that constant caused various lilo setups to not boot
> > anymore. I don't know who is actually to blame, just wanting to
> > point out that this "obvious" patch isn't actually that obvious.
> > 
> 
> How would that even be possible (unless you recompiled LILO with the new 
> headers)?  There would be no difference in the memory image at the point 
> LILO hands off to the kernel.

AFAIK the problem was that some EDD data got overwritten.

> 
> In order to reproduce this we need some details about your "various LILO 
> setups", or this will remain as a source of cargo cult programming.

You can search the mailing list archives, it's all in there if you don't
belive me.

-Andi

