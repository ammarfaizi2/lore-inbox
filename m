Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLARgY>; Fri, 1 Dec 2000 12:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLARgQ>; Fri, 1 Dec 2000 12:36:16 -0500
Received: from 216-99-201-166.hurrah.com ([216.99.201.166]:37382 "EHLO
	magic.skylab.org") by vger.kernel.org with ESMTP id <S129348AbQLARgB>;
	Fri, 1 Dec 2000 12:36:01 -0500
Date: Fri, 1 Dec 2000 09:05:23 -0800 (PST)
From: "T. Camp" <campt@openmars.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
In-Reply-To: <Pine.LNX.4.21.0012011655300.1488-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012010904260.4856-100000@magic.skylab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> indeed, much cleaner. But still not perfect.
> 
> > +	int root_device_index = 0;
> 
> this initialisation is not needed. Just make it 'int root_device_index;'
> The kernel will do the right thing for you on boot, trust me.
> 
> > +int number_root_devs = 0;
> 
> this is not needed either.
Hmm didn't know that, from the user-land portable C perspective I'm in the
habit of zero'ing everything. - thanks.

t.

Fear the future?  Change the past. 
 This message has resulted in an increase in the entropy of the universe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
