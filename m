Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSCTTQB>; Wed, 20 Mar 2002 14:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293150AbSCTTPy>; Wed, 20 Mar 2002 14:15:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35311
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312054AbSCTTPi>; Wed, 20 Mar 2002 14:15:38 -0500
Date: Wed, 20 Mar 2002 11:16:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-160-lru_release_check
Message-ID: <20020320191644.GA29857@matchmail.com>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C980990.1C6B232A@zip.com.au> <Pine.NEB.4.44.0203201703450.3932-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 05:09:32PM +0100, Adrian Bunk wrote:
> On Tue, 19 Mar 2002, Andrew Morton wrote:
> 
> >...
> > +		if (unlikely(in_interrupt()))
> > +			BUG();
> >...
> 
> Is there a reason against intruducing BUG_ON in 2.4? It makes such things
> more readable.
> 

I think there are plans to do so...

... But not in this patch.
