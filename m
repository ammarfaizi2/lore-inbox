Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282855AbRK0ID1>; Tue, 27 Nov 2001 03:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282862AbRK0IDL>; Tue, 27 Nov 2001 03:03:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34312 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282851AbRK0IBb>;
	Tue, 27 Nov 2001 03:01:31 -0500
Date: Tue, 27 Nov 2001 09:01:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>,
        "Nathan G. Grennan" <ngrennan@okcforum.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127090113.X5129@suse.de>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <3C02C06A.E1389092@zip.com.au> <20011127084234.V5129@suse.de> <20011126235853.A9391@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011126235853.A9391@mikef-linux.matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26 2001, Mike Fedyk wrote:
> On Tue, Nov 27, 2001 at 08:42:34AM +0100, Jens Axboe wrote:
> > On Mon, Nov 26 2001, Andrew Morton wrote:
> > > 2: The current elevator design is downright cruel to humans in
> > > the presence of heavy write traffic.
> > 
> > max_bomb_segments logic was established to help absolutely _nothing_ a
> > long time ago.
> > 
> > I agree that the current i/o scheduler has really bad interactive
> > performance -- at first sight your changes looks mostly like add-on
> > hacks though. Arjan's priority based scheme is more promising.
> > 
> 
> Based on pid priority or niceness?

None of the above yet. It isn't hard to add process I/O priority and
inherit that once the support is there in the i/o scheduler / block
layer, though.

-- 
Jens Axboe

