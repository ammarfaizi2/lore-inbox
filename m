Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVCOWx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVCOWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCOWw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:52:58 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:15270 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262117AbVCOWwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:52:19 -0500
Subject: Re: [PATCH] Add missing refrigerator calls
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110925639.9818.80.camel@pegasus>
References: <1110924757.6454.132.camel@desktop.cunningham.myip.net.au>
	 <1110925639.9818.80.camel@pegasus>
Content-Type: text/plain
Message-Id: <1110927223.6454.148.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 16 Mar 2005 09:53:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-03-16 at 09:27, Marcel Holtmann wrote:
> Hi Nigel,
> 
> > There are a number of threads that currently have no refrigerator
> > handling in Linus' tree. This patch addresses part of that issue. The
> > remainder will be addressed in other patches, following soon.
> > 
> > Signed-off-by: Nigel Cunningham <ncunningham@cyclades.com>
> 
> I am fine with the net/bluetooth/rfcomm/ part, but what about the bnep/
> and cmtp/ and hidp/ part of the Bluetooth subsystem? Do we need this
> there, too?

I see... someone has added PF_NOFREEZE to all your drivers, so my
fragment is redundant. NO_FREEZE is fine in my mind - I would be seeking
to make all network driver threads NO_FREEZE in a while anyway, to allow
suspending over a network.

I'll double check the other fragments too, just in case the same thing
has happened there.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

