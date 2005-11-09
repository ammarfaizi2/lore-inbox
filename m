Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVKILiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVKILiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVKILiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:38:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:38277 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751364AbVKILiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:38:09 -0500
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1131531428.8506.24.camel@localhost.localdomain>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
	 <1131117293.26925.46.camel@localhost.localdomain>
	 <20051104163755.GB13420@kroah.com>
	 <1131531428.8506.24.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Nov 2005 12:08:34 +0000
Message-Id: <1131538115.6540.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-09 at 10:17 +0000, Richard Purdie wrote:
> > Having done testing on the cards I have based on RMK's suggestion I
> > agree they are not removable except for specific cases (IDE PCMCIA cable
> > adapter plugged into a Syquest). That case is already handled in the
> > core code.
> 
> Alan: Can you confirm the patch below continues to handle the case
> you're talking about?

It does. The Syquest is picked up later on in the driver itself.

Alan

