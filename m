Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSFKOiF>; Tue, 11 Jun 2002 10:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSFKOiE>; Tue, 11 Jun 2002 10:38:04 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:39172 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S317104AbSFKOiC>; Tue, 11 Jun 2002 10:38:02 -0400
Date: Tue, 11 Jun 2002 16:38:01 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Giuliano Pochini <pochini@shiny.it>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: bandwidth 'depredation'
In-Reply-To: <XFMail.20020611151754.pochini@shiny.it>
Message-ID: <Pine.LNX.4.44.0206111628280.17534-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Giuliano Pochini wrote:

> 
> On 11-Jun-2002 DervishD wrote:
> >     Hello all :))
> >
> >     I've noticed that, when using certain programs like 'wget', the
> > bandwidth seems to be 'depredated' by them. When I download a file
> > with lukemftp or with links, the bandwidth is then distributed
> > between all IP clients, but when using wget or some ftp clients, it
> > is not distributed. BTW, I'm using an ADSL line (128 up / 256 down).
> >
> >     IMHO, the IP layer (well, in this case the TCP layer) should
> > distribute the bandwidth (although I don't know how to do this), and
> > the kernel seems to be not doing it.
> 
> No, IP doesn't balance anything. You have to filter the traffic with
> QoS of traffic shapers to give different "priorities" to packets as
> you like. Wget doesn't "grab" the bandwidth, it's the remote server
> that fills it.

This is my understanding, too.

But so how is QoS going to change things? It's the output queue of
the router on the other side of the ADLS link that needs management
(and maybe you need to speak some protocol like RSVP), or am I missing
something? How can you control the rate of *incoming* packets per
connection / protocol? 

.TM.

