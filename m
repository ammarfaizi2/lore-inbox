Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935004AbWK1BAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935004AbWK1BAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935003AbWK1BAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:00:13 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:34196 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S935004AbWK1BAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:00:11 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 27 Nov 2006 19:53:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] kconfig:  Remove obsolete CONFIG_DMA_IS_DMA32 entries
 from ia64 config files
In-Reply-To: <20061127231409.GQ15364@stusta.de>
Message-ID: <Pine.LNX.4.64.0611271953290.5308@localhost.localdomain>
References: <Pine.LNX.4.64.0611271631480.4759@localhost.localdomain>
 <20061127231409.GQ15364@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006, Adrian Bunk wrote:

> On Mon, Nov 27, 2006 at 04:37:35PM -0500, Robert P. J. Day wrote:
> >
> >   Remove the obsolete CONFIG_DMA_IS_DMA32 entries from the various
> > "defconfig" files under arch/ia64.
> >...
>
> I do not like this manual editing of defconfigs:
> - obsolete options in defconfigs don't cause any harm
> - the next time someone refreshes the defconfigs they will
>   automatically go away
> - if it became common to manually patch defconfigs, we'd soon get
>   many patch conflicts

ah, i was not aware that those files were auto-generated.  my mistake.

rday
