Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRJ2Qkc>; Mon, 29 Oct 2001 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276255AbRJ2QkS>; Mon, 29 Oct 2001 11:40:18 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:17928 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S276305AbRJ2Qjr>; Mon, 29 Oct 2001 11:39:47 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Mon, 29 Oct 2001 11:40:20 -0500
To: linux-kernel@vger.kernel.org, crazed_cowboy@stones.com
Cc: Daniel Freedman <freedman@ccmr.cornell.edu>
Subject: Re: ECS k7s5a motherboard doesnt work
Message-ID: <20011029114018.A29371@ccmr.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Justin Mierta (Crazed_Cowboy@stones.com) wrote:
> and nowhere can i find the thread you mentioned. 
> 
> Also, this motherboard works *perfect* in windows (which is 
> unfortunately where i've been stuck) -- it hasnt crashed in the last 
> several weeks i've been using it! (probably the longest uptime i've ever 
> seen for a windows machine that's actually being used) So I *seriously* 
> doubt its bad hardware. 
> 
> Can you maybe give me a link to the thread you mention? 
> 
> Justin 
> 

Justin,

Hi!  I've purchased three of these ECS K7S5A motherboards (based upon
Sis 735 chipsets) and have installed Linux (specifically Debian 2.2r3,
with 2.2.19 kernel) on all of them without any difficulty or hiccups.
This would tend to suggest, as Alan implied, that the board is not
incompatible (at least not wildly so, as you describe) and that you
may have hardware issues, even if Windows does run on this setup.

The main issue that I believe exists with this board, or actually with
the board's chipset (people, please correct me if I'm wrong), is that
the current 2.2.19 does not support the built-in ethernet capabilities
of the Sis 735.  I've tried Sis's patch for the kernel from their
website, but that won't even compile.  I'm planning to look into Alan's
2.2.20pre11 release that supposedly includes a Sis900 chipset update
(Sis seems to suggest that the 900 and 735 use the same drivers, at
least to some degree) and maybe this will work.  In the meantime, I
just installed a NIC.

Hope this helps, Justin.  I'd love to hear if anyone else knows about
the Sis735 ethernet issue.

Take care,
Daniel

PS Please CC me on replies.

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
