Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263761AbRFDEDr>; Mon, 4 Jun 2001 00:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263827AbRFDEDh>; Mon, 4 Jun 2001 00:03:37 -0400
Received: from www.transvirtual.com ([206.14.214.140]:19724 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S263761AbRFDED2>; Mon, 4 Jun 2001 00:03:28 -0400
Date: Sun, 3 Jun 2001 21:02:18 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Andries.Brouwer@cwi.nl,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: keyboard hook?
In-Reply-To: <20010603110239.A4982@513.holly-springs.nc.us>
Message-ID: <Pine.LNX.4.10.10106032056310.14554-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks, I'm loking through your driver now. Does the input api 
> already/currently support ps2 keyboards?

With the current tree no. The work around is to make input api keyboards
behave as PS/2 keyboards. In 2.5.X ps2 keyboards will be input api based. 
As you can see we already have PS/2 input api driver (i8042.c and atkbd.c). 
I have been using it for several months now. It is just a matter of making
sure it works on other platforms besides intel. 

P.S
   I also need to port other keyboard drivers on other platforms over to
the input api and test these drivers. If anyone would like to help out
contact me.

