Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133034AbRDRG1w>; Wed, 18 Apr 2001 02:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133037AbRDRG1n>; Wed, 18 Apr 2001 02:27:43 -0400
Received: from zmailer.org ([194.252.70.162]:31492 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S133034AbRDRG1i>;
	Wed, 18 Apr 2001 02:27:38 -0400
Date: Wed, 18 Apr 2001 09:27:29 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Your response is requested
Message-ID: <20010418092729.P805@mea-ext.zmailer.org>
In-Reply-To: <20010417222555.L805@mea-ext.zmailer.org> <20010417190405.PTFU6564.tomts8-srv.bellnexxia.net@mail.vger.kernel.org> <Pine.LNX.4.33.0104171212520.960-100000@batman.zarzycki.org> <20010417222555.L805@mea-ext.zmailer.org> <11637.987548621@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11637.987548621@redhat.com>; from dwmw2@infradead.org on Wed, Apr 18, 2001 at 12:03:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 12:03:41AM +0100, David Woodhouse wrote:
> matti.aarnio@zmailer.org said:
> >   Actually not.  Either your MTA, or your MUA did that.
> >   I got:
> > 	From:   J. I.
> >   This particular detail -- when to add canonical domain to e.g. From:
> >   address, and when not -- is implemented rather fuzzily usually.. 
> 
> I'm in the "if it arrives unqualified by SMTP from !localhost, reject it"
> camp. I certainly can't think of a single case where it's appropriate to
> accept it _and_ qualify it with the local domain in that case.

	I didn't look for what it was at the SMTP level while
	incoming, but RFC 821 (SMTP) is the transport method, and
	VGER won't accept unqualified ( + a few more rules )

	What you are saying is that RFC 822 level (visible headers)
	should be controlled for something ?

	I have a surprise for you, RFC 822 data carries only incidental
	resemblance with the message content and destination.

	Like now, you (dwmw2) get this message twice: once from me
	which means the "From:" might even carry some resemblance
	to the sender (yes, resemblance, it isn't my login-id, just
	my email address), the second one comes via the list, and
	the Majordomo won't change the From: to be
		linux-kernel-owner@vger.kernel.org
	which is the real sender in that case...

	... and this is completely off topic ...
> --
> dwmw2

/Matti Aarnio
