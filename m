Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRDKO0B>; Wed, 11 Apr 2001 10:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDKOZA>; Wed, 11 Apr 2001 10:25:00 -0400
Received: from datafoundation.com ([209.150.125.194]:9225 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S132581AbRDKOYj>; Wed, 11 Apr 2001 10:24:39 -0400
Date: Wed, 11 Apr 2001 10:24:32 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: info <5740@mail.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 compile error No 4
In-Reply-To: <01041118154201.30945@sh.lc>
Message-ID: <Pine.LNX.4.30.0104111022470.19243-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, info wrote:

> > this may be a stupid question, but are you doing a 'make clean' after
> > changing config parameters?
>
> Maybe it's is a stupid order, but I  do this:
> 1. untar kernel into /usr/src (there was no /linux subdirectory)
>  2. copy my own config file (named config-k6) from old 2.4.0 source
> tree (compiled and working - now I am on 2.4.0)
> 3. make xconfig, load configuration from this file and then manually
> check all parameters
> 4 store configuration into new config-k6-1 file
> 5. press button "Save and exit"

why not copy it over to .config, 'make oldconfig', then pop into your
favourite configuration editor and make changes, making sure to save them
on exit?

then do a 'make clean; make dep; make'


