Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSIISjG>; Mon, 9 Sep 2002 14:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318805AbSIISiw>; Mon, 9 Sep 2002 14:38:52 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:32191 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318802AbSIISio>;
	Mon, 9 Sep 2002 14:38:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 20:25:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Imran Badr <imran.badr@cavium.com>, "'David S. Miller'" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com> <20020909181355.GA1510567@sgi.com>
In-Reply-To: <20020909181355.GA1510567@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oTES-0006qj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 20:13, Jesse Barnes wrote:
> On Mon, Sep 09, 2002 at 02:00:35PM -0400, Richard B. Johnson wrote:
> > Well I just read Documentation/DMA-mapping.txt as advised by David
> > and it seems as though it will no longer be possible to do what
> > many programmers have been wanting to do, to wit:
> > 
> > (1) In user-code, allocate a buffer.
> > (2) Lock that buffer into memory.
> > (3) Call some driver that DMAs data to/from that buffer.
> 
> It looks drivers/media/video/video-buf.c uses alloc_kiovec() and
> map_user_kiobuf() to do it.  And I think Ben LaHaise was talking about
> removing these functions and creating some other, lightweight
> interface for the same purpose?

Hopefully.  My understanding is that kio is obsoleted by bio and aio,
anyone want to confirm/deny this?

-- 
Daniel
