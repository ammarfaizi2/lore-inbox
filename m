Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271348AbRIFQhg>; Thu, 6 Sep 2001 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271349AbRIFQh0>; Thu, 6 Sep 2001 12:37:26 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:265 "HELO castle.nmd.msu.ru")
	by vger.kernel.org with SMTP id <S271348AbRIFQhK>;
	Thu, 6 Sep 2001 12:37:10 -0400
Message-ID: <20010906204423.B23109@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 20:44:23 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Wietse Venema <wietse@porcupine.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru> <20010906155811.BC78DBC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010906155811.BC78DBC06C@spike.porcupine.org>; from "Wietse Venema" on Thu, Sep 06, 2001 at 11:58:11AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 11:58:11AM -0400, Wietse Venema wrote:
> Andrey Savochkin:
> > Of course, SIOCGIFCONF isn't even close to provide the list of local
> > addresses.
> > Obvious example: it doesn't enlist all addresses 127.0.0.1, 127.0.0.2 etc.
> > on common systems.  If you handle 127.0.0.2 as local, you apply side
> 
> 127.0.0.2 is not local on any of my systems. The only exceptions
> are some Linux boxen that I did not ask to do so.
> 
> I welcome suggestions, maybe even code fragments, that will allow
> an MTA to correctly recognize user@[ip.address] as local, as required
> by the SMTP RFC.

The question was which ip.address in user@[ip.address] should be treated as
local.
My comment was that the only reasonable solution on Linux is to treat this
way addresses explicitly specified in the configuration file.
Postfix may show its guess at the installation time.

Now the question of recognizing user@[ip.address] as local is a question of a
simple table lookup.

Best regards
		Andrey
