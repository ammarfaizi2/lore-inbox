Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287170AbSABXFY>; Wed, 2 Jan 2002 18:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287166AbSABXFS>; Wed, 2 Jan 2002 18:05:18 -0500
Received: from tourian.nerim.net ([62.4.16.79]:46350 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S287169AbSABXFA>;
	Wed, 2 Jan 2002 18:05:00 -0500
Message-ID: <3C339219.4040808@free.fr>
Date: Thu, 03 Jan 2002 00:04:57 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu> <20020102172448.A18153@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

 > Alan Cox <alan@lxorguk.ukuu.org.uk>:
 >
 >>So you want the lowest possible priviledge level. Because if so thats
 >>setuid app not kernel space. Arguing about the same code in either kernel
 >>space verus setuid app space is garbage.
 >>
 >
 > But you're thinking like a developer, not a user.  The right question
 > is which approach requires the lowest level of *user* privilege to get
 > the job done.  Comparing world-readable /proc files versus a setuid app,
 > the answer is obvious.


Reading proc files requires running kernel space code, do we have kernel
space code running with *user* priviledge now?

 >  This sort of thing is exactly what /proc is *for*.
 >


Hum, "/proc" is only good for _flamewars_ on lklm ;-)

LB.


