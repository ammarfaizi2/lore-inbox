Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289059AbSANJqO>; Mon, 14 Jan 2002 04:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288993AbSANJqF>; Mon, 14 Jan 2002 04:46:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:54283 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288944AbSANJpu>;
	Mon, 14 Jan 2002 04:45:50 -0500
Date: Mon, 14 Jan 2002 10:45:32 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: zippel@linux-m68k.org, rml@tech9.net, ken@canit.se, arjan@fenrus.demon.nl,
        landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020114104532.59950d86.skraw@ithnet.com>
In-Reply-To: <E16PvKx-00005L-00@the-village.bc.nu>
In-Reply-To: <200201140033.BAA04292@webserver.ithnet.com>
	<E16PvKx-00005L-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 00:50:54 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > all of it? You will not be far away in the end from the 'round 4000 I 
> > already stated in earlier post.                                       
> 
> There are very few places you need to touch to get a massive benefit. Most
> of the kernel already behaves extremely well.

Just a short question: the last (add-on) patch to mini-ll I saw on the list
patches: drivers/net/3c59x.c
drivers/net/8139too.c
drivers/net/eepro100.c

Unfortunately me have neither of those. This would mean I cannot benefit from
_these_ patches, but instead would need _others_ (like tulip or
name-one-of-the-rest-of-the-drivers) to see _some_ effect you tell me I
_should_ see (I currently see _none_). How do you argue then against the
statement: we need patches for /drivers/net/*.c ?? I do not expect 3c59x.c to
be particularly bad in comparison to tulip/*.c or lets say via-rhine.c, do you?

> > So I understand you agree somehow with me in the answer to "what idea 
> > is really better?"...                                                 
> 
> Do you want a clean simple solution or complex elegance ? For 2.4 I
definitely> favour clean and simple. For 2.5 its an open debate

Hm, obviously the ll-patches look simple, but their pure required number makes
me think they are as well stupid as simple. This whole story looks like making
an old mac do real multitasking, just spread around scheduling points
throughout the code ... This is like drilling for water on top of the mountain.
I want the water too, but I state there must be a nice valley somewhere around
...

Regards,
Stephan
 
