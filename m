Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281197AbRKLXmi>; Mon, 12 Nov 2001 18:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281199AbRKLXm2>; Mon, 12 Nov 2001 18:42:28 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48886
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281197AbRKLXmO>; Mon, 12 Nov 2001 18:42:14 -0500
Date: Mon, 12 Nov 2001 15:42:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Frank de Lange <lkml-frank@unternet.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
Message-ID: <20011112154208.D32099@mikef-linux.matchmail.com>
Mail-Followup-To: Martin Josefsson <gandalf@wlug.westbo.se>,
	Frank de Lange <lkml-frank@unternet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011112152123.C32099@mikef-linux.matchmail.com> <Pine.LNX.4.21.0111130025130.26022-100000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111130025130.26022-100000@tux.rsn.bth.se>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 12:27:00AM +0100, Martin Josefsson wrote:
> On Mon, 12 Nov 2001, Mike Fedyk wrote:
> 
> > On Mon, Nov 12, 2001 at 11:56:42PM +0100, Frank de Lange wrote:
> > [snip]
> > > Seems that reiserfs is the common factor here, at least on my box. This is a 35
> > > GB reiserfs filesystem, app 80% used, both large and small files.
> > > 
> > > As said in my previous message, the numbers themselves don't mean squat. It is
> > > the large delays (the fact that user+sys <<< real) which are the problem here.
> > > 
> > > Any other magic anyone wants me to perform? Hans, you reading this?
> > > 
> > 
> > Do you see/hear a lot of seeking happing during the delays?
> 
> Yup this is probably what's happening to me. I didn't think a harddrive
> could do so many seeks so fast :)
> 

Check out the thread "reiserfs performance loss" back in oct 12 and 13...

Mike
