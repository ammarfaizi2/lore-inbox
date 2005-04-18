Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVDRM1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVDRM1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVDRM1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:27:54 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:32773 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262056AbVDRM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:27:49 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Ehud Shabtai <eshabtai.lkml@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Need some help to debug a freeze on 2.6.11
Date: Mon, 18 Apr 2005 15:27:02 +0300
User-Agent: KMail/1.5.4
Cc: Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org
References: <68b6a2bc050418000619a552de@mail.gmail.com> <Pine.LNX.4.62.0504181220090.2522@dragon.hyggekrogen.localhost> <68b6a2bc05041803561621ddd6@mail.gmail.com>
In-Reply-To: <68b6a2bc05041803561621ddd6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504181527.02112.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 April 2005 13:56, Ehud Shabtai wrote:
> On 4/18/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > On Mon, 18 Apr 2005, Jesper Juhl wrote:
> > 
> > > On Mon, 18 Apr 2005, Alexander Nyberg wrote:
> > >
> > > > Sounds like a job for Documentation/networking/netconsole.txt
> > > >
> > > or Documentation/serial-console.txt
> > >
> > Console on line printer would also be an option.
> 
> I don't have any printer port cables, so I guess I prefer to try netconsole.
> 
> I'm using wireless lan (Intel's ipw2100), would netconsole work on
> wlan interface?

That depends on how far ipw2100 is into 'softmac' land.
That is, if it uses host CPU for some of it's functions,
it may be inoperative.

Wired net have more chances of working.

> As an alternative, can I configure netconsole for my ethernet port and
> only really connect it, after I get the freeze?

UDP packets will be long gone at the time you plug cable in.
--
vda

