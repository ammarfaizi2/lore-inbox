Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264564AbRF1Vrq>; Thu, 28 Jun 2001 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264550AbRF1Vrg>; Thu, 28 Jun 2001 17:47:36 -0400
Received: from [216.102.46.130] ([216.102.46.130]:30782 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S264506AbRF1VrX>; Thu, 28 Jun 2001 17:47:23 -0400
To: Pekka Pietikainen <pp@evil.netppl.fi>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux and system area networks
In-Reply-To: <20010627154140.A14908@netppl.fi> <Pine.LNX.4.33.0106281918560.32296-100000@kenzo.iwr.uni-heidelberg.de> <20010628221227.A24517@netppl.fi>
From: Roland Dreier <roland@topspincom.com>
Date: 28 Jun 2001 14:46:49 -0700
In-Reply-To: Pekka Pietikainen's message of "Thu, 28 Jun 2001 22:12:27 +0300"
Message-ID: <52d77o46ra.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Pekka> If you used sockets, I believe the normal way to use SAN
    Pekka> boards is to just make them look like network cards with a
    Pekka> large MTU Sure it works, but it's not very efficient :) (I
    Pekka> have to admit I've not played with that kind of toys at
    Pekka> all, though)

We seem to have come full circle.  My original question was about
providing a better way for sockets applications to take advantage of
SAN hardware.  W2K Datacenter introduces "Winsock Direct," which will
bypass the protocol stack when appropriate.  The Infiniband people are
working on a "Sockets Direct" standard, which is a similar idea.  No
one seems to care about this for Linux.

Roland
