Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbTCaIll>; Mon, 31 Mar 2003 03:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbTCaIll>; Mon, 31 Mar 2003 03:41:41 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:4369 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261483AbTCaIlk>; Mon, 31 Mar 2003 03:41:40 -0500
Date: Mon, 31 Mar 2003 10:52:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: bert hubert <ahu@ds9a.nl>
cc: Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030331083157.GA29029@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0303311039190.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com>
 <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com>
 <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Mar 2003, bert hubert wrote:

> > If Andries would actually explain, what he wants to do with the larger 
> > dev_t, it would be a lot easier to help him, so that we can at least avoid 
> > the biggest mistakes.
> 
> Can you envision solutions based on 16 bit kdev_t infrastructure? 

I know that 16bit is getting small (but with dynamic assignment even 
that is still enough for most people), but OTOH I don't understand the 
obsession for 64bit. 32bit is more than enough on a 32bit system.
Somehow it sounds that we just have to introduce a huge dev_t and all our 
problems are magically solved and I doubt that. If people want to encode 
random information into dev_t, then even 64bit will be soon not enough 
anymore, so I want to know how people actually want to use that large 
dev_t number. Is that really too much to ask?
(Slowly I'm getting the feeling that there is some sort of 64bit dev_t 
conspiracy going on here, with the amount of answers I'm (not) getting 
here.)

bye, Roman

