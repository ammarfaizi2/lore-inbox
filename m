Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTELODn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTELODn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:03:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24020 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261881AbTELODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:03:42 -0400
Date: Mon, 12 May 2003 16:16:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
Message-ID: <20030512141619.GO1107@fs.tum.de>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 03:39:11PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

>...
> BTW this clears my todo list of important features for the kconfig syntax 
> itself, if you think there is something missing, please tell me now, 
> otherwise it might have to wait for 2.7. After this I work a bit more on 
> xconfig and the library interface.
>...

there's one feature I'd like to see (I don't see an easy way to achieve 
it currently):

A choice with the possibility to select one or more entries, to support 
things like:
  Supported processors:
    [ ] 386
    [ ] 486
    [ ] 586
    ...

It should be possible to select more than one item but selecting zero 
items should be illegal.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

