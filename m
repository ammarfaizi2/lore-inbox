Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTE0E0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTE0E0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:26:47 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62215 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263332AbTE0E0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:26:46 -0400
Date: Tue, 27 May 2003 06:39:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, gibbs@scsiguy.com,
       acme@conectiva.com.br
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030527043936.GB19309@alpha.home.local>
References: <1053732598.1951.13.camel@mulgrave> <20030524064340.GA1451@alpha.home.local> <1053923112.14018.16.camel@rth.ninka.net> <1053995708.17151.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053995708.17151.42.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:35:09AM +0100, Alan Cox wrote:
 
> One thing I will say however - I'd have done the *same* thing as Marcelo
> with aic7xxx during -rc which is to defer it.

I think you would at least have forwarded problem reports to Justin, expecting
him to look into the problem first.

I don't reproach Marcelo of not including the last aic7xxx driver in mainline,
but of reverting an enormous amount of code at the last minute without prior
asking the maintainer if he has an idea about the problem people encounter. Of
course, if he hasn't, the driver has to be removed, but he gave him no chance
to fix it, nor any detail about who had problems and what type of problems they
had. And reverting to what it was in 2.4.20 is not safer than trying to fix,
since other code touched in 2.4.21 may bring side effects (APIC ?) which might
explain why it doesn't work for some people.

> The simple truth is that when you give something to 10,000 users instead of
> 20 something breaks. Its not that authors suck its just another testimony to
> the fact computer programming is still firmly at the alchemy not the
> chemistry end of its history.

and that computer makers can't read the specs !

> If the driver works well fine, but maintainers don't have the ability to
> see into the future either.

It reminds me that I often worry when one of my programs runs right on the
first compilation, because it doesn't give me the opportunity of puting my
nose into sensible places where I could find obvious bugs :-)

Regards,
Willy

