Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293218AbSCRW6k>; Mon, 18 Mar 2002 17:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293224AbSCRW6a>; Mon, 18 Mar 2002 17:58:30 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:35849 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293206AbSCRW6R>;
	Mon, 18 Mar 2002 17:58:17 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 15:56:28 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020318155628.L4783@host110.fsmlabs.com>
In-Reply-To: <20020318153637.J4783@host110.fsmlabs.com> <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately so.  I have some boards here that have higher precision
timers but nothing approaching the clock rate of the chip.  I don't think
there are any PPC boards with timers at that rate.

Some of the 6xx or 74xx model debug registers may have something useful
here, though.

} Oh, you're cycle timer is too slow to be interesting, apparently ;(
