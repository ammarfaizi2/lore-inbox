Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284464AbRLIVtE>; Sun, 9 Dec 2001 16:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284467AbRLIVsy>; Sun, 9 Dec 2001 16:48:54 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:8956 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S284464AbRLIVso>;
	Sun, 9 Dec 2001 16:48:44 -0500
Date: Sun, 9 Dec 2001 16:45:01 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: <kuznet@ms2.inr.ac.ru>
cc: <ahu@ds9a.nl>, <lartc@mailman.ds9a.nl>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
In-Reply-To: <200112091814.VAA00499@ms2.inr.ac.ru>
Message-ID: <Pine.GSO.4.30.0112091642480.6079-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > > But to do this, you would need to be able to set skb->priority to a 32bit
> > > number:
> > >
> >
> > Cant think of a straight way to do this .... Alexey would know,
>
> SO_PRIORITY. Or I did not follow you?
>

So priority limits the size of skb->priority to be from 0..6; this wont
work with that check in cbq.

cheers,
jamal

