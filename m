Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272521AbRH3WLr>; Thu, 30 Aug 2001 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272523AbRH3WLi>; Thu, 30 Aug 2001 18:11:38 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:529 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S272519AbRH3WLW>;
	Thu, 30 Aug 2001 18:11:22 -0400
Date: Thu, 30 Aug 2001 16:11:39 -0600
From: Val Henson <val@nmt.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Lost TCP retransmission timer
Message-ID: <20010830161139.A18224@boardwalk>
In-Reply-To: <20010829195259.B11544@boardwalk> <200108301621.UAA05134@ms2.inr.ac.ru> <20010830121025.A15880@boardwalk> <20010830.145609.42773013.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010830.145609.42773013.davem@redhat.com>; from davem@redhat.com on Thu, Aug 30, 2001 at 02:56:09PM -0700
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 02:56:09PM -0700, David S. Miller wrote:
> 
> BTW, you mentioned that you are seeing this on PPC, do you have any
> way to verify if the bug can be triggered on any other platform?

I'm currently away from my x86 workstation, but I can try it this
weekend.

The requirements for triggering this are:

2.4.6 or higher kernel
2.4.6 machine pushes lots of data on _first_ TCP connection after boot
Lots of packets from 2.4.6 machine are dropped (I'm using 10 Mb hub)

-VAL
