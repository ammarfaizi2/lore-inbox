Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbRG3VaR>; Mon, 30 Jul 2001 17:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267988AbRG3VaH>; Mon, 30 Jul 2001 17:30:07 -0400
Received: from ns.caldera.de ([212.34.180.1]:18606 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268055AbRG3VaA>;
	Mon, 30 Jul 2001 17:30:00 -0400
Date: Mon, 30 Jul 2001 23:29:56 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010730232956.A20969@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Vitaly Fertman <vitaly@namesys.com>
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com> <20010730224930.A18311@caldera.de> <3B65CC07.24E3EF4C@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B65CC07.24E3EF4C@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 01:05:11AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 01:05:11AM +0400, Hans Reiser wrote:
> There is nothing like a distro maintainer

	[NOTE:  I do not maintain the Caldera kernel RPM, but I was
		involved in the decision to turn reiserfs debugging on]

> overriding the design decisions made
> by the lead architect of a package, not believing that said architect knows what
> the fuck he is doing.

Reiserfs lately had a lot of stability issues, reports of data corruption
and as you said before you don't considere the reiserfs version in 2.4.2-ac
stable yourself.

The averange user will not blame you if he loses data through a problem
in reiserfs but the distribtuion, even if this filesystem is clearly
marked unsupported.

> 
> We will make this unusable by you from this point onwards.
> 

I do not see the debug kernel removed from the official kernel tree
before reiserfs has proven known stable.

Of course there is still the option of CONFIG_REISERFS_FS=n if you
intentionally want to make your filesystem less acceptable..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
