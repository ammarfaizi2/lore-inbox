Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTBXXJW>; Mon, 24 Feb 2003 18:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTBXXJW>; Mon, 24 Feb 2003 18:09:22 -0500
Received: from holomorphy.com ([66.224.33.161]:17587 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261855AbTBXXJV>;
	Mon, 24 Feb 2003 18:09:21 -0500
Date: Mon, 24 Feb 2003 15:18:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224231825.GR10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <20030224050650.GI27135@holomorphy.com> <1046099212.1246.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046099212.1246.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 05:06, William Lee Irwin III wrote:
>> Try 4 or 8 mkfs's in parallel on a 4x box running virgin 2.4.x.

On Mon, Feb 24, 2003 at 03:06:53PM +0000, Alan Cox wrote:
> You have strange ideas of typical workloads. The mkfs paralle one is a good
> one though because its also a lot better on one CPU in 2.5

The results I saw were that this did not affect 2.5 in any interesting
way and 2.4 behaved "very badly".

It's a simple way to get lots of disk io going without a complex
benchmark. There are good reasons and real workloads why things were
done to fix this.


-- wli
