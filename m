Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAGJbQ>; Sun, 7 Jan 2001 04:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRAGJbH>; Sun, 7 Jan 2001 04:31:07 -0500
Received: from UX4.SP.CS.CMU.EDU ([128.2.198.104]:27505 "HELO
	ux4.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S129729AbRAGJa7>;
	Sun, 7 Jan 2001 04:30:59 -0500
Subject: Re: Speed of the network card
To: Chris Wedgwood <cw@f00f.org>
Date: Sun, 7 Jan 2001 04:30:30 -0500 (EST)
From: Sourav Ghosh <sourav@ux4.sp.cs.cmu.edu>
Cc: sourav@cs.cmu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20010107144819.B1617@metastasis.f00f.org> from "Chris Wedgwood" at Jan 7, 2001 02:48:19 pm
Reply-To: sourav@cs.cmu.edu
X-Mailer: ELM [version 2.4 PL25-40]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010107093100Z129729-400+1338@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, Jan 06, 2001 at 08:20:02PM -0500, Sourav Ghosh wrote:
> 
>     I was wondering how I can determine the speed of a network device
>     inside the kernel.
> 
> what kind of network card?
>     
>     In case of ethernet, the "name" field  of device structure will
>     only give eth0 or something. But the speed could be either 10Mbps
>     or 100Mbps.
> 

Well, I need to clarify the question.

I would like to determine the banwidth the card is getting from
the network. 
For an ethernet, it could be either 10Mbps or 100Mbps, is there any
way of knowing from inside the kernel how much is the bandwidth the
card is actually receiving from the network, especially when it is capable of
getting either 10Mbps or 100Mbps?
  


> we don't have a good was on doing this sort of thing, you could try
> mii-tool though; it supports many cards
> 
> 
> 
>   --cw

-- 
Sourav


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
