Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318847AbSG0WcH>; Sat, 27 Jul 2002 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSG0WcG>; Sat, 27 Jul 2002 18:32:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37127 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318847AbSG0WcF>; Sat, 27 Jul 2002 18:32:05 -0400
Date: Sat, 27 Jul 2002 19:35:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Buddy Lumpkin <b.lumpkin@attbi.com>,
       Austin Gonyou <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       Ville Herva <vherva@niksula.hut.fi>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
In-Reply-To: <1027813211.21516.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0207271933200.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jul 2002, Alan Cox wrote:
> On Sat, 2002-07-27 at 23:22, Buddy Lumpkin wrote:
> > I thought linux worked more like Solaris where it didn't use any swap (AT
> > ALL) until it has to... At least, I hope linux works this way.
>
> I'd be suprised if Solaris did something that dumb.
>
> You want to push out old long unaccessed pages of code to make room for
> more cached disk blocks from files.

AFAIK they quietly removed priority paging from Solaris 8,
somewhat embarrasing considering the publicity at its
introduction with Solaris 7, but no more embarrasing than
the regular VM rewrites Linux undergoes ;/

Now only if VM was a well-understood area and we could just
implement something known to work ... OTOH, that would take
away all the fun ;)

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

