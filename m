Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264007AbRF1TMq>; Thu, 28 Jun 2001 15:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRF1TMg>; Thu, 28 Jun 2001 15:12:36 -0400
Received: from mean.netppl.fi ([195.242.208.16]:60678 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S263906AbRF1TMb>;
	Thu, 28 Jun 2001 15:12:31 -0400
Date: Thu, 28 Jun 2001 22:12:27 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux and system area networks
Message-ID: <20010628221227.A24517@netppl.fi>
In-Reply-To: <20010627154140.A14908@netppl.fi> <Pine.LNX.4.33.0106281918560.32296-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.LNX.4.33.0106281918560.32296-100000@kenzo.iwr.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 07:28:20PM +0200, Bogdan Costescu wrote:
> On Wed, 27 Jun 2001, Pekka Pietikainen wrote:
> 
> I'm sorry, but I don't understand your reference to MPI here. MPI is a
> high-level API; MPI can run on top of whatever communication features
> exists: TCP/IP, shared memory, VI, etc.

Well, the way I understood the discussion was about how you can
utilize your new $$$ SAN boards well with your existing applications.
If you used something like MPI you just switch to a new implementation
optimized for your network (and hope the new one is compatible
with your code ;) )

Of course you can use some lower-level API and get better 
performance, but your programs will undoubtedly be more complicated
and probably need to be rewritten for new APIs every now and then.

If you used sockets, I believe the normal way to use SAN boards
is to just make them look like network cards with a large MTU 
Sure it works, but it's not very efficient :) (I have to admit 
I've not played with that kind of toys at all, though)

-- 
Pekka Pietikainen



