Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265359AbSJSK4u>; Sat, 19 Oct 2002 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSJSK4u>; Sat, 19 Oct 2002 06:56:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4041 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265359AbSJSK4t> convert rfc822-to-8bit; Sat, 19 Oct 2002 06:56:49 -0400
Date: Sat, 19 Oct 2002 13:02:48 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Corey Minyard <cminyard@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver for Linux, version 7
In-Reply-To: <3DACD6E3.6020707@mvista.com>
Message-ID: <Pine.NEB.4.44.0210191249240.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Corey Minyard wrote:

> In the continuing saga of IPMI driver updates, here's another installment.
>
> More cleanups and bug fixes, some from Arjan van de Ven, and others from
> myself. This fixes some problems with blocking operations while holding
> a lock. It has an unfortunate interface change (but better now than
> later), the lun field is removed from the IPMI message, and one is added
> to the system interface address. It's a minor change, but it really
> needed to be done to make things consistent. It's only released as a
> patch to the v6 version and it applies cleanly to all kernel versions.
>  As usual, you can download the driver from my home page at
> http://home.attbi.com/~minyard.
>
> -Corey
>
> PS - In case you don't know, IPMI is a standard for system management,
> it provides ways to detect the managed devices in the system and sensors
> attached to them.  You can get more information at
> http://www.intel.com/design/servers/ipmi/spec.htm

<--  snip  -->

...
Adopters Agreement:

Before implementing the IPMI, IPMB or ICMB specifications, a royalty-free
reciprocal patent license must be signed. Please follow the steps below to
sign the IPMI Adopters Agreement:
...
·  Adopter hereby grants to the Promoters and to Fellow Adopters, and the
   Promoters hereby grant to Adopter, a nonexclusive, royalty-free,
   nontransferable, nonsublicenseable, worldwide license under its
   Necessary Claims to make, have made, use, import, offer to sell and
   sell products which comply with the Specification; provided that such
   license shall not extend to features of a product which are not
   required to comply with the Specification or for which there exists a
   feasible, noninfringing alternative.
...

<--  snip  -->


Am I right that this makes it impossible to include an IPMI driver into
the kernel (this isn't GPL-compatible)?


cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


