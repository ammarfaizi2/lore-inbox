Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263220AbSJGXX4>; Mon, 7 Oct 2002 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263223AbSJGXX4>; Mon, 7 Oct 2002 19:23:56 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:5801 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S263220AbSJGXXw>;
	Mon, 7 Oct 2002 19:23:52 -0400
Date: Tue, 8 Oct 2002 01:33:45 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Hell.Surfers@cwctv.net
cc: linux-kernel@vger.kernel.org, Tomasz Rola <rtomek@cis.com.pl>
Subject: RE:Re: v.34 rockwell support in 2.4.**
In-Reply-To: <06ad129421507a2DTVMAIL4@smtp.cwctv.net>
Message-ID: <Pine.LNX.3.96.1021008003314.2747C-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 7 Oct 2002 Hell.Surfers@cwctv.net wrote:

> No, I think I know the difference, the kernel IS supposed to support hardware modems, as for winmodems, ive written a HSP to help port them, which if anybody wants, mail me, i'll set up a sourceforge site for it soon.
> 
> Cheers, Dean.

Well, you are right - the kernel support for winmodem is good if one wants
to use ppp et al. On the other hand, it seems that having support for some
specialised protocol can produce a lot of overhead in some cases. For
example, I once owned very simple Zoltrix, that could do error correction
and compression only via the software driver (available only for windows, 
of course). So, it was almost unusable until I started doing ppp on it.
The ppp driver took care about errors and compression - now, with the same
futures implemented in lower layers it would be a waste of cpu.

So, if you want to do kernel support for winmodem, it would be probably
good to remember about ppp. Of course, if you choose to implement full
support and emulate v34 or anything else, you would be able to turn the
compression (and || or) error correction off either on the emulated
'modem' or in ppp options.

Anyway, I think you could have a look at www.linmodems.org. It seems to
contain some interesting things.

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

iQA/AwUBPaIZ3xETUsyL9vbiEQKPTQCgjkpc5XOnc2Odk99KjxPueMNc5WMAn3L3
cywKCdIoTjERP9ET9lkwMBhC
=ErB6
-----END PGP SIGNATURE-----


