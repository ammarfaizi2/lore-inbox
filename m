Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271335AbRHTQVx>; Mon, 20 Aug 2001 12:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271336AbRHTQVo>; Mon, 20 Aug 2001 12:21:44 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:11896 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S271335AbRHTQVb>; Mon, 20 Aug 2001 12:21:31 -0400
Date: Mon, 20 Aug 2001 18:21:38 +0200
From: Cliff Albert <cliff@oisec.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Yusuf Goolamabbas <yusufg@outblaze.com>, linux-kernel@vger.kernel.org,
        gibbs@scsiguy.com
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820182138.C26054@oisec.net>
In-Reply-To: <20010820105520.A22087@oisec.net> <E15YmR3-0005mb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15YmR3-0005mb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 11:37:33AM +0100, Alan Cox wrote:

> > > With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
> > > compile with APIC enabled and APIC on UP also enabled, it boots
> > > cleanly
> > 
> > I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> > the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> > i've been getting these errors since 2.4.3.
> 
> There is a known BIOS irq routing table problem with a large number of Intel
> BIOS boards with onboard adaptec controllers. The fact that making it use
> the io-apic works suggest this is the same thing.

It's an ASUS P2B-S board with a Award Bios, flashed to the latest revision that
is available from ASUS

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
