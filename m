Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUIOOyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUIOOyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUIOOyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:54:37 -0400
Received: from chello062179026180.chello.pl ([62.179.26.180]:39859 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S266273AbUIOOye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:54:34 -0400
Date: Wed, 15 Sep 2004 16:55:53 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Andre Bonin <kernel@bonin.ca>
cc: linux-kernel@vger.kernel.org, Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: PCI coprocessors
In-Reply-To: <41483BD3.4030405@bonin.ca>
Message-ID: <Pine.LNX.3.96.1040915164509.26011A-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 15 Sep 2004, Andre Bonin wrote:

> Hey all,
[...]
> Which leads me to my questions:
> 
> 1) Is their support for having two different 'machine types' within one 
> kernel? that is for example, certain executables for intel would get run 
> on an intel processor, and others would get run on processor with type XXXX.

There are probably no impossible things - some may be unthinkable but once
they are thought of, they can be done too. But this one thing may be
rather difficult (just my opinion).

How about porting kernel and gcc to your fp-cpu and use pci as a
kind of fast network-like interconnect? After loading a kernel into it
somehow, boot it with nfs root and run the rest from nfs server that would
be provided by a host Intel machine.

That would require less changes to a kernel, probably. A module for a
host, for example - some "pci-net". And port of a kernel to your fp-cpu
which should be easier than putting support for heterogenous
multiprocessors...

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

iQA/AwUBQUhX/xETUsyL9vbiEQKAlACg9Rv6rD8INCQFItk1/s5OfZbXjukAn2Mp
PGjv6ihFXwTInSn8nu3ZOKpu
=E5XU
-----END PGP SIGNATURE-----


