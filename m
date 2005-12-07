Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVLGTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVLGTsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVLGTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:48:19 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:50102 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP id S964936AbVLGTsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:48:18 -0500
Date: Wed, 7 Dec 2005 11:47:36 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Michael Renzmann <netdev@nospam.otaku42.de>,
       Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051207194736.GF8942@jm.kir.nu>
References: <20051206224728.GA31894@bougret.hpl.hp.com> <20051207071102.GC8953@jm.kir.nu> <20051207191622.GB1913@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207191622.GB1913@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:16:22AM -0800, Jean Tourrilhes wrote:

> 	Well, the burning question is : Is it possible to include your
> Atheros driver in the Linux kernel ? Meaning, will it be released, and
> will it contain a binary blob ?

If that were possible, it would have been released with the IEEE 802.11
code. It has the same issue as madwifi in the sense of depending on
Atheros hal code.

> 	Not cool. I usually don't like wrapper, but would it be
> possible to wrap the IPW API around DeviceScape ?

I would not even like to think about that.. ;-) I think we are in a
position where we are way more willing to change things than try to
maintain current interfaces in backwards compatible ways.

> > Prism2/2.5/3 is getting somewhat old nowadays and I certainly prefer

> 	It's old, but because it's the only current card properly
> supported under Linux, most people are still using it. And you have
> many original Prism2 designs that you can't find with other chipset,
> such as the high power version and the CF cards.

Agreed and as such, it is still on my list of things to maintain.
However, this certainly means that it is likely to be of lower priority
than some of the newer chipsets.

-- 
Jouni Malinen                                            PGP id EFC895FA
