Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUIPBNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUIPBNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUIPBMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:12:48 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:46223 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267450AbUIPBHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:07:06 -0400
Date: Thu, 16 Sep 2004 03:05:09 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-ID: <20040916010509.GP15426@dualathlon.random>
References: <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <1095275660.20569.0.camel@localhost.localdomain> <20040915135308.78bf74f0.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915135308.78bf74f0.davem@davemloft.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:53:08PM -0700, David S. Miller wrote:
> There are absolutely no justified economics in these
> TOE engines.  By the time you deploy them, the cpus
> and memory catch up and what's more those are general
> purpose and not just for networking as David Stevens
> and others have said.

I'm not sure if economics are the worst part of what is being shipped,
to me the worst part is security, I'd never trust myself such a
non-open-source TCP stack for something critical even if it was going to
be much cheaper and performant. Even my PDA is using the linux tcp
stack, and my cell phone only speaks UDP with the wap server anyways.
TCP segment offload OTOH doesn't involve much "intelligence" in the NIC
and it's very reasonable to trust it especially because all the incoming
packets (the real potential offenders) are still processed by the linux
tcp stack.
