Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270840AbUJUVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270840AbUJUVqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271001AbUJUVis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:38:48 -0400
Received: from bdsl.66.14.157.209.gte.net ([66.14.157.209]:34796 "EHLO
	greg.sparky.org") by vger.kernel.org with ESMTP id S271006AbUJUVg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:36:29 -0400
Date: Thu, 21 Oct 2004 14:36:00 -0700
From: Greg Buchholz <greg@sleepingsquirrel.org>
To: Timothy Miller <miller@techsource.com>
Cc: John Ripley <jripley@rioaudio.com>,
       "'Greg Buchholz'" <linux@sleepingsquirrel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041021213600.GB675@sleepingsquirrel.org>
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177FF47.5040005@techsource.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> Ok, I'll bite.  What you're suggesting is that instead of developing 
> just a graphics card, I should develop a card populated with a bunch of 
> FPGA's that's reprogrammable.  Putting aside the logic design tool issue 
> (which may be difficult), what you'd get is a very expensive 
> reprogrammable card with some RAM and some video output hardware.
> 
> How much would you pay for THIS card?  $2000?

   $300

 Here's a rough breakdown (FPGA $ => http://makeashorterlink.com/?F23722699

    $52 for 8 (eight!) Spartan 3/400 (XC3S400 = $6.50 @ 250k qty)
    $30 for 256MB DRAM
    $60 for Board, D/A, manufacturing, etc.
   ----
   $142 rough guesstimate hardware costs
   $158 for software/profit
> 
> Now, the thing is, this card is SO generic that Tech Source would have 
> very little value-add.  Say we populate it with a bunch of Spartan 3 
> 400's... well, you'd download Xilinx's WebPack, code up your design in 
> Verilog 

    Yeah, that's probably the catch, because I'd want to use gvs (GNU
verilog/VHDL synthesis ;)

> (Do you want to learn chip design???  It's not like programming 
> in C!!!), and then use our open source utility to upload your code.

    Chip design isn't that much different than writing code.  Plus it
would be a great learning experience for anyone who hasn't tried a
hardware design language.  (Kinda like how learning lisp is an eye
opener for most people).  Besides, I think someone would eventually
port or create some interesting high level concurrent languages to use.
(I could see some interesting primitives added to a language like Erlang
or Oz to try to exploit the parallel nature of the FPGAs)

> GREAT... until some other company comes along and clones it, which would 
> be WAY too easy to do.  Now, for the users of this sort of product, it's 
> a fine thing. 

    It might not turn out to be a high profit margin business, but then
again, I don't think slapping together "white boxes" is high margin
either, but there doesn't seem to be a shortage of them.

> But it becomes a pointless investment for Tech Source, 
> which is where I work and who pays me to work on this stuff, which they 
> wouldn't do if it's not worth it.

    The hardest part would seem to be the software needed, i.e. a free
synthesizer/mapper.  But somehow we've managed to create an entire free
operating system.  I suppose it just takes time.  Maybe in another 5/10
years.  Or maybe we need to think of a better way to fund open hardware
projects.  If there were 25,000 of us who really wanted this project, we
could pay our $300 into an escrow account ($7.5E6 total).  When the
boards were delivered, the manufacturing company would get half the
money, and when version 1.0 of the software was completed, they'd get
the other half.  Surely a bank would loan money against that kind of
collateral.  But now I'm probably rambling.


Greg Buchholz

