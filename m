Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286283AbRLTQOS>; Thu, 20 Dec 2001 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286284AbRLTQOI>; Thu, 20 Dec 2001 11:14:08 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:32211 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S286283AbRLTQN6>; Thu, 20 Dec 2001 11:13:58 -0500
Message-ID: <3C220ED2.F5B01AD4@kegel.com>
Date: Thu, 20 Dec 2001 08:16:18 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <20011219171631.A544@burn.ucsd.edu>
		<20011219.172046.08320763.davem@redhat.com>
		<20011219182628.A13280@burn.ucsd.edu> <20011219.184527.31638196.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> If AIO was so relevant+sexy we'd be having threads of discussion about
> the AIO implementation instead of threads about how relevant it is or
> is not for the general populace.  Wouldn't you concur?  :-)
> 
> The people doing Java server applets are such a small fraction of the
> Linux user community.

People writing code for NT/Win2K/WinXP are being channelled into
using AIO because that's the way to do things there (NT doesn't
really support nonblocking I/O).  Thus another valid economic
reason AIO is important is to make it easier to port code from NT.
I have received requests from NT folks for things like aio_recvfrom()
(and have passed them on to Ben), so I'm not just guessing here.

As should be clear from my c10k page, I love nonblocking I/O,
but I firmly believe that some form of AIO is vital.

- Dan
