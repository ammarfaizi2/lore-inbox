Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135837AbRDTJg6>; Fri, 20 Apr 2001 05:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135836AbRDTJgs>; Fri, 20 Apr 2001 05:36:48 -0400
Received: from [193.228.81.158] ([193.228.81.158]:14573 "EHLO stefan.sime.com")
	by vger.kernel.org with ESMTP id <S135838AbRDTJgb>;
	Fri, 20 Apr 2001 05:36:31 -0400
Date: Fri, 20 Apr 2001 11:36:06 +0200
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stefan@hello-penguin.com, Andi Kleen <ak@suse.de>, Dave <daveo@osdn.com>,
        linux-kernel@vger.kernel.org
Subject: Re: bizarre TCP behavior
Message-ID: <20010420113606.A1113@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010414141208.A31782@stefan.sime.com> <E14oR1o-00051n-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14oR1o-00051n-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Apr 14, 2001 at 03:27:53PM +0100
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.3 (i686)
X-APM: 100% 400 min
X-MIL: A-6172171143
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 12 14 21 22 40 45
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 03:27:53PM +0100, Alan Cox wrote:
> > For example the Zyxel 681 SDSL-Router breaks ECN by
> > stripping 0x80 (ECN Cwnd Reduced) but not 0x40 (ECN Echo)
> > (TOS bits) on all SYN packets (!).
> > 
> > I complained because of this two times more than a month ago
> > but they do not even respond.
> 
> If the router claims to be RFC compliant then you may want to investigate
> trading standards bodies. In the UK at least things like the advertising 
> standards agency get upset by people who claim standards compliance, are shown
> not to be compliant and are not fixing things..

FYI: I just tested a beta firmare that does not break ECN.
(ZyXEL firmware v2.50(T.05)b6 | 03/28/2001)

I hope that Zyxel will make a release soon, the last official firmare
does not support it. (Ahm, people that are willing to upgrade should
do it on _both_ sides)

-- 

  ciao - 
    Stefan
