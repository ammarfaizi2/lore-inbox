Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTA0REm>; Mon, 27 Jan 2003 12:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTA0REm>; Mon, 27 Jan 2003 12:04:42 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:42757 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S267216AbTA0REk>;
	Mon, 27 Jan 2003 12:04:40 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Mon, 27 Jan 2003 18:13:55 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Ross Biro <rossb@google.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
In-Reply-To: <3E356403.9010805@google.com>
Message-ID: <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
 <3E356403.9010805@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Ross Biro wrote:

> This looks like the same problem I ran into with IDE and highmem not
> getting along.  Try compiling your kernel with out highmem enabled and
> see what happenes.

Yes, that "fixes" it. Any "better solution"? ;-)

> >Trace; c024dfc1 <ide_build_sglist+181/1a0>
> >Trace; c024e1b4 <ide_build_dmatable+54/1a0>
> >Trace; c024e6df <__ide_dma_read+3f/150>

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
