Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281016AbRKCTIh>; Sat, 3 Nov 2001 14:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281017AbRKCTIc>; Sat, 3 Nov 2001 14:08:32 -0500
Received: from pD951AA6B.dip.t-dialin.net ([217.81.170.107]:46474 "EHLO
	power.suche.org") by vger.kernel.org with ESMTP id <S281016AbRKCTIT>;
	Sat, 3 Nov 2001 14:08:19 -0500
Message-ID: <3BE44096.2070808@bewegungsmelder.de>
Date: Sat, 03 Nov 2001 20:08:06 +0100
From: Thomas Lussnig <tlussnig@bewegungsmelder.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: null, de-de, de, en-gb, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org, khttpd mailing list <khttpd-users@zgp.org>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <Pine.LNX.4.30.0111031900230.9228-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>how much do you think you can get out of a server with several 1Gb
>ethernet cards, multiple 66MHz/64bit PCI busses, multiple SCSI busses or
>perhaps some sort of SAN solution based on FibreChannel 2?
>
Ok,
on this hardware i think that the problem is the that the Kernel and
Webserver need to suport that ( each of the 1Gbit card is bound to its
own process and on Multiprozessor machine that the prozess is fixed to
one CPU to minimize the siwtch overhead, also im not firm with the 
FibreChannel2
spezifikation i think that there can some trouble with the load, but much
more important is to know how much different data is served, because then
you talk about khttpd i think that it is definit static data and so the 
question
is how much, because on an ideal case the whole set of files is cached 
in the
ram, with 500 hundred Users i think there is only minmal patch in the 
kernel to
do for higher file handles. So if there is only there the choice left open
tux or khttpd i think you should use tux

- more defelopment
- more tuning/config/log options
- better code ( khttpd soud's a little bit of try and error )


