Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130799AbRCFA3o>; Mon, 5 Mar 2001 19:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130803AbRCFA3e>; Mon, 5 Mar 2001 19:29:34 -0500
Received: from mail1.mail.iol.ie ([194.125.2.192]:7952 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S130799AbRCFA3Y>;
	Mon, 5 Mar 2001 19:29:24 -0500
Date: Tue, 6 Mar 2001 00:29:12 +0000
From: Kenn Humborg <kenn@linux.ie>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc() alignment
Message-ID: <20010306002912.A14827@excalibur.research.wombat.ie>
In-Reply-To: <3AA2C488.54A792AD@colorfullife.com> <20010306000652.A13992@excalibur.research.wombat.ie> <981a78$cb2$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <981a78$cb2$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Mar 05, 2001 at 04:15:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 04:15:36PM -0800, H. Peter Anvin wrote:
> > So, to summarise (for 32-bit CPUs):
> > 
> > o  Alan Cox & Manfred Spraul say 4-byte alignment is guaranteed.
> > 
> > o  If you need larger alignment, you need to alloc a larger space,
> >    round as necessary, and keep the original pointer for kfree()
> > 
> > Maybe I'll just use get_free_pages, since it's a 64KB chunk that
> > I need (and it's only a once-off).
> > 
> 
> It might be worth asking the question if larger blocks are more
> aligned?

OK, I'll bite...

Are larger blocks more aligned?

Later,
Kenn

