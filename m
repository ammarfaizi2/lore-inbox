Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbUATAd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUATA1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:27:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:38609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265173AbUATADR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:03:17 -0500
Subject: Re: aacraid and 2.6
From: Mark Haverkamp <markh@osdl.org>
To: Miek Gieben <miekg@atoom.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nathan Poznick <kraken@drunkmonkey.org>
In-Reply-To: <20040119180930.GA9391@atoom.net>
References: <20040119102647.GA23288@atoom.net>
	 <20040119135228.GA7935@tao.wang-fu.org> <20040119135619.GA32393@atoom.net>
	 <20040119180505.GS1748@srv-lnx2600.matchmail.com>
	 <20040119180930.GA9391@atoom.net>
Content-Type: text/plain
Message-Id: <1074556990.25357.19.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 19 Jan 2004 16:03:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 10:09, Miek Gieben wrote:
> [On 19 Jan, @19:05, Mike wrote in "Re: aacraid and 2.6 ..."]
> > > hmmm, did you have any luck with 2.6.1?
> > > 
> > > In this case it's a SATA raid from Adaptec. So, if aacraid if not ide-raid, why
> > > doesn't it work? 
> > 
> > And what errors did you get?
> 
> none, when modprobing aacraid it just said:
> AAC-RAID ....etc...
> 
> and no device /dev/sde found stuff like under 2.4.
> 
> grtz
>       Miek
> --
> "So long, and thanks for all the fish."
> -- Hitchhikers Guide to the Galaxy


It looks like there are some adapters in the 2.4 driver that aren't
specified in the 2.6 driver.  Check linit.c in 2.4 and 2.6.



-- 
Mark Haverkamp <markh@osdl.org>

