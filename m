Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSGDTwF>; Thu, 4 Jul 2002 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSGDTwE>; Thu, 4 Jul 2002 15:52:04 -0400
Received: from 1-003.ctame701-2.telepar.net.br ([200.181.138.3]:42481 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S313563AbSGDTwD>; Thu, 4 Jul 2002 15:52:03 -0400
Date: Thu, 4 Jul 2002 16:54:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Manfred Spraul <manfred@colorfullife.com>,
       linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
Message-ID: <20020704195432.GD7534@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com> <20020703170521.E8033@one-eyed-alien.net> <3D248208.4060500@colorfullife.com> <20020704125012.C17360@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704125012.C17360@one-eyed-alien.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 04, 2002 at 12:50:12PM -0700, Matthew Dharm escreveu:
> > > Because relying on a pointer has caused problems in the past, especially
> > > when there are concerns that the pointer might be invalid.

> > Could you explain a bit more? How could the pointer become invalid?
 
> There was a large discussion of this in relation to another driver on
> linux-usb-devel... basically, the pointer is just an address to a structure
> owned by an HCD... it's entirely possible for the structure to go away on
> us unexpectedly.  We _should_ get the notification via the _disconnect()
> call, but real-world experience showed us that this wasn't always
> happening.

Humm, I believed that USB was using refcounting

- Arnaldo
