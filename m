Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJDIpU>; Thu, 4 Oct 2001 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273141AbRJDIpK>; Thu, 4 Oct 2001 04:45:10 -0400
Received: from peace.netnation.com ([204.174.223.2]:24583 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S273269AbRJDIpB>; Thu, 4 Oct 2001 04:45:01 -0400
Date: Thu, 4 Oct 2001 01:45:24 -0700
From: Simon Kirby <sim@netnation.com>
To: jamal <hadi@cyberus.ca>
Cc: Ben Greear <greearb@candelatech.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011004014524.A1496@netnation.com>
In-Reply-To: <20011003130203.A2315@netnation.com> <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Wed, Oct 03, 2001 at 09:04:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 09:04:22PM -0400, jamal wrote:

> I think you can save yourself a lot of pain today by going to a "better
> driver"/hardware. Switch to a tulip based board; in particular one which
> is based on the 21143 chipset. Compile in hardware traffic control and
> save yourself some pain.

Or an Acenic-based card, but that's more expensive.

The problem we had with Tulip-based cards is that it's hard to find a
good model (variant) that is supported with different kernel versions and
stock drivers, doesn't change internally with time, and is easily
distinguishable by our hardware suppliers.  "Intel EtherExpress PRO100+"
is difficult to get wrong, and there are generally less issues with
driver compatibility because there are many fewer (no) clones, just a few
different board revisions.  The same goes with 3COM 905/980s, etc.

I'm not saying Tulips aren't better (they probably are, competition is
good), but eepro100s are quite simple (and have been reliable for our
servers much more than 3com 905s and other cards have been in the past).

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
