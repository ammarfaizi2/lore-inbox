Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSGNRYR>; Sun, 14 Jul 2002 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSGNRYQ>; Sun, 14 Jul 2002 13:24:16 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:53777 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316953AbSGNRYP>; Sun, 14 Jul 2002 13:24:15 -0400
Date: Sun, 14 Jul 2002 19:27:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jerry McBride <mcbrides9@comcast.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing include...
Message-ID: <20020714172705.GB12015@louise.pinerecords.com>
References: <20020714120440.6b7eb93b.mcbrides9@comcast.net> <20020714165357.GA12015@louise.pinerecords.com> <20020714131714.17d8773b.mcbrides9@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714131714.17d8773b.mcbrides9@comcast.net>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 40 days, 8:44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > In compiling 2.4.18 I find that this include is missing from the
> > > source... linux-2.4.18/include/linux/version.h
> > 
> > It is not. You have just failed to follow the kernel build instructions:
> > See /usr/src/linux/README.
> 
> I read it, I printed it out. Where does it discuss a missing version.h
> include?

$SRCDIR/include/linux/version.h is a generated file. "make dep" will create
an instance of it for you.

T.
