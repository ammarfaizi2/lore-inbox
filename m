Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbSLFJA3>; Fri, 6 Dec 2002 04:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLFJA3>; Fri, 6 Dec 2002 04:00:29 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43789 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267582AbSLFJA1>; Fri, 6 Dec 2002 04:00:27 -0500
Message-Id: <200212021430.gB2EUEp09020@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Thomas Molina <tmolina@copper.net>, "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [PATCH] README change
Date: Mon, 2 Dec 2002 17:20:05 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211272057230.924-100000@lap.molina>
In-Reply-To: <Pine.LNX.4.44.0211272057230.924-100000@lap.molina>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 November 2002 01:26, Thomas Molina wrote:
> Enclosed is a second version, incorporating your suggestions.
>
> On Wed, 27 Nov 2002, Barry K. Nathan wrote:
> > Again, s/compiler/library/ (i.e., undo your change, it was right
> > the first time)
> >
> > > +   happens to be.
>
> Reverted.  I did change the word area to directory, which is all I
> originally intended anyway.

IMHO /user/src/linux have nothing to do with glibc headers.
Any half-sanely configured glibc will have all relevant kernel
headers installed under /usr/include/{asm|linux} (most probably copied
from a kernel tree).

The sad fact is that these are symlinks on many systems in Real World.

In short, on sanely configured system you should be able to rm -rf /usr/src,
then untar some $source and configure/build it successfully.
--
vda
