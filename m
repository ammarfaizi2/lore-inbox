Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271683AbRH0JyD>; Mon, 27 Aug 2001 05:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271684AbRH0Jxy>; Mon, 27 Aug 2001 05:53:54 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:12554 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S271683AbRH0Jxp>; Mon, 27 Aug 2001 05:53:45 -0400
Date: Mon, 27 Aug 2001 11:53:57 +0200
From: Jan Niehusmann <jan@gondor.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
Message-ID: <20010827115357.A1335@gondor.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0B7@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0B7@orsmsx35.jf.intel.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 02:26:09AM -0700, Grover, Andrew wrote:
> system's ACPI tables indicates they can be used. If you are attempting to
> use C2 even if your system explicitly does not support it, you are asking
> for trouble, just like AMD's errata says.

Motherboard vendors may have disabled the bus disconnection because of a
3% performance hit, to make their boards look better in benchmarks.
In that case, the system may run perfectly stable with disconnection reenabled.

I agree that these experiments should not be performed on a production
system :) 

> This results in better battery life on a laptop but that is irrelevant on a
> desktop system.

Well, I think saving ~55W is relevant, even on a desktop system. I plan
to measure how much power these hacks really save, and if it's more than
10W, I think it's worth some more work in this area.

Jan

(asus writes that one of the problems that can happen with this power
saving mode are the huge changes in power dissipation, from 60W to 5W
and back - therefore I assume the power saving mode can save up to 55W)
