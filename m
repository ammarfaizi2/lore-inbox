Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318746AbSHGO2c>; Wed, 7 Aug 2002 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318749AbSHGO2c>; Wed, 7 Aug 2002 10:28:32 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:2825 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318746AbSHGO2c>; Wed, 7 Aug 2002 10:28:32 -0400
Date: Wed, 7 Aug 2002 16:31:52 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergio Avila <sergio@evoto.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at page_alloc.c:117!
Message-ID: <20020807143152.GA5991@louise.pinerecords.com>
References: <200208071509.30398.sergio@evoto.org> <1028734409.18478.302.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028734409.18478.302.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 64 days, 6:12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [1.] One line summary of the problem:
> > 
> >         kernel BUG at page_alloc.c:117!
> 
> >         Aug  7 04:17:25 lordvaider kernel: NVRM: AGPGART: freed 16 
> > pages
> >         Aug  7 04:17:25 lordvaider kernel: NVRM: AGPGART: backend 
> 
> Please report this to Nvidia. The linux community does not support or
> care about bugs reported on any boot when their binary only modules have
> been loaded

And in case you're wondering whether lkml people are being assholes about
binary-only drivers and don't really want to help, note that this particular
bug has been confirmed many times to indeed be caused by the Nvidia module.

T.
