Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUIPASa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUIPASa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUIPAPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 20:15:49 -0400
Received: from chello062179026180.chello.pl ([62.179.26.180]:2183 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S267656AbUIPALY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 20:11:24 -0400
Date: Thu, 16 Sep 2004 02:12:16 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Tonnerre <tonnerre@thundrix.ch>
cc: Andre Bonin <kernel@bonin.ca>, linux-kernel@vger.kernel.org,
       Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: PCI coprocessors
In-Reply-To: <20040915164914.GG24818@thundrix.ch>
Message-ID: <Pine.LNX.3.96.1040916015212.26011C-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 15 Sep 2004, Tonnerre wrote:

> Salut,
> 
> On Wed, Sep 15, 2004 at 04:55:53PM +0200, Tomasz Rola wrote:
> > After loading  a kernel into it  somehow, boot it with  nfs root and
> > run the rest from nfs server  that would be provided by a host Intel
> > machine.
> 
> I'd rather not do that via nfs. Rather some special "hostfs" port over
> PCI.

Well, "there is more than one way of doing this", it seems.

> But  anyway, reading  his original  post  he seems  to have  something
> completely different  in mind than booting  a second PC on  his PC: to
> boot a supportive processor..

Erm, somehow I came to thinking he wanted to schedule binaries on cpus of
different types.

Anyway, Andre, you are welcome :-).

One more thing - I remember reading on one Polish newsgroup devoted to
electronics, that making PCI cards is rather difficult (actually, nobody
wanted to try it) while one can do ISA cards "at home" or something like
this. I know ISA is out of business, but for "proof of concept" it may be
a better choice. Or maybe you (Andre) can do it with USB chip - it should
be even easier to make such device with USB and connect it to your host
this way. There are quite a few controllers available. I've searched for
ATMEL's and found this:

http://www.atmel.com/dyn/products/devices.asp?family_id=655

Of course, there must be others, too.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBQUjaaBETUsyL9vbiEQLi1wCg8stbROOHy36NUN15uZ2XW1/LGp0An0fy
m0ynDnyoOkf+aRUxt0v502vk
=qHKK
-----END PGP SIGNATURE-----


