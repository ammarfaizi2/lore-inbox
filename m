Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRDQPBg>; Tue, 17 Apr 2001 11:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRDQPB1>; Tue, 17 Apr 2001 11:01:27 -0400
Received: from ns.suse.de ([213.95.15.193]:9234 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132696AbRDQPBN>;
	Tue, 17 Apr 2001 11:01:13 -0400
Date: Tue, 17 Apr 2001 17:01:10 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Andi Kleen <ak@suse.de>, Eric Weigle <ehw@lanl.gov>,
        Sampsa Ranta <sampsa@netsonic.fi>, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org, zebra@zebra.org
Subject: Re: ARP responses broken!
Message-ID: <20010417170110.A10430@gruyere.muc.suse.de>
In-Reply-To: <20010417161919.A8842@gruyere.muc.suse.de> <Pine.LNX.4.21.0104171652360.9099-100000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104171652360.9099-100000@tux.rsn.bth.se>; from gandalf@wlug.westbo.se on Tue, Apr 17, 2001 at 04:53:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 04:53:01PM +0200, Martin Josefsson wrote:
> On Tue, 17 Apr 2001, Andi Kleen wrote:
> 
> > On Mon, Apr 16, 2001 at 03:26:19PM -0600, Eric Weigle wrote:
> > > Hello-
> > > 
> > > This is a known 'feature' of the Linux kernel, and can help with load sharing
> > > and fault tolerance. However, it can also cause problems (such as when one nic
> > > in a multi-nic machine fails and you don't know right away).
> > > 
> > > There are three 'solutions' I know of:
> > > 
> > >   * In recent 2.2 kernels, it was possible to fix this by doing the following as
> > 
> > Or use arpfilter in even newer 2.2 kernels; which filters based on the routing
> > table. "hidden" is quite a sledgehammer which often does more harm than good.
> 
> Does arpfilter exist in 2.4 kernels?

Not yet, will be merged very soon. I can send you a patch if you need it urgently.


-Andi
