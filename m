Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSANUDD>; Mon, 14 Jan 2002 15:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSANUBw>; Mon, 14 Jan 2002 15:01:52 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1544 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289004AbSANUAz>;
	Mon, 14 Jan 2002 15:00:55 -0500
Date: Mon, 14 Jan 2002 21:00:39 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-Id: <20020114210039.180c0438.skraw@ithnet.com>
In-Reply-To: <E16QDKf-0002kT-00@the-village.bc.nu>
In-Reply-To: <20020114204818.24a253cc.skraw@ithnet.com>
	<E16QDKf-0002kT-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 20:03:49 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > bttv                   60848   0 
> 
> bttv wants a reasonable amount
> 
> > NVdriver              720128  14  (autoclean)
> 
> Thats my guess. Mapping all the memory on your geofarce will not be a small
> amount.

Ok. So what do we do about it? I mean there are possibly some more people out
there with such a problem, or - to my prediction - there will be more in the
future. I see to possibilities:
1) simply increase it overall. I have not the slightest idea what the drawbacks
are. 2) make it configurable (looks like general setup to me).

I could provide a patch for either. Do we want that?

Regards,
Stephan

