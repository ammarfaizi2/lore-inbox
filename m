Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbTFNPqA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 11:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265688AbTFNPp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 11:45:59 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:26793 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id S265687AbTFNPpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 11:45:54 -0400
Date: Sat, 14 Jun 2003 17:59:38 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
X-X-Sender: dzimi@ep09.kernel.pl
To: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
cc: Stephan von Krawczynski <skraw@ithnet.com>, "" <stefan@stefan-foerster.de>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21 released
In-Reply-To: <20030613171903.GA797@deimos.one.pl>
Message-ID: <Pine.LNX.4.50L.0306141753020.20957-100000@ep09.kernel.pl>
References: <200306131453.h5DErX47015940@hera.kernel.org>
 <20030613165628.GE28609@in-ws-001.cid-net.de> <20030613165625.GA573@deimos.one.pl>
 <20030613193709.49f22332.skraw@ithnet.com> <20030613171903.GA797@deimos.one.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Damian [iso-8859-2] Ko³kowski wrote:

> Date: Fri, 13 Jun 2003 19:19:03 +0200
> From: "Damian [iso-8859-2] Ko³kowski" <deimos@deimos.one.pl>
> To: Stephan von Krawczynski <skraw@ithnet.com>
> Cc: stefan@stefan-foerster.de, linux-kernel@vger.kernel.org
> Subject: Re: linux-2.4.21 released
> 
> On Fri, Jun 13, 2003 at 07:37:09PM +0200, Stephan von Krawczynski wrote:
> > How about telling the maintainer?
> 
> That is a good idea, but I thought that someone else have that trouble too, so I
> ignore that.
> 
> I will report the bug with via-rhine to ACPId maintainers.

I have got the same problem few days ago. Quick fix was: append="noapic 
acpi=off"
I did not check new apci stuff, maybe acpi maintainers fixed that bug ? If 
they are changes should go as soon as possible into Marcelo bk tree :)

Krzysiek Taraszka			(dzimi@pld.org.pl)
http://cyborg.kernel.pl/~dzimi/
arch/sparc64/kernel/traps.c: 
/* Why the fuck did they have to change this? */

