Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSKWMcK>; Sat, 23 Nov 2002 07:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSKWMcK>; Sat, 23 Nov 2002 07:32:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15811 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266996AbSKWMcJ>; Sat, 23 Nov 2002 07:32:09 -0500
Date: Sat, 23 Nov 2002 13:39:16 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New kconfig: Please add define_*
Message-ID: <20021123123916.GB14886@fs.tum.de>
References: <20021121133320.GD18869@fs.tum.de> <Pine.LNX.4.44.0211211740130.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211211740130.2113-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 05:55:42PM +0100, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Thu, 21 Nov 2002, Adrian Bunk wrote:
> 
> > one thing that easily leads to errors is that the difference between
> > e.g. bool and define_bool is less obvious than before (it's no longer
> > explicitely stated). If there's no string behind the bool and no
> > "prompt" line it's now treated as define_bool. I've already found two
> > places in sound/oss/Kconfig where this was missing accidentially. Could
> > you add explicite define_* back to the config language and let the
> > program quit with an error if there's e.g. a define_bool with a string
> > or prompt line or a bool without a string or prompt line?
> 
> It was not missing accidentially, these symbols were defined with 
> define_bool before.
>...

/me checks 2.5.44

You are right, it was a define_bool before. I thought "this must be a
bug" and I didn't even read the comments above the options...

A define_bool might make it more obvious for dumb people like me that it
is really intended the way it is.  ;-)

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

