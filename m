Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSHGWiS>; Wed, 7 Aug 2002 18:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSHGWiS>; Wed, 7 Aug 2002 18:38:18 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:5385 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316903AbSHGWiR> convert rfc822-to-8bit; Wed, 7 Aug 2002 18:38:17 -0400
Date: Thu, 8 Aug 2002 00:41:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <jmacd@namesys.com>, <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <E17cZJi-00050N-00@starship>
Message-ID: <Pine.LNX.4.44.0208080035020.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002, Daniel Phillips wrote:

> > +#define MUST_HOLD_RW(lock)             do { } while(0)
>
> Random gripe: don't all those do { } whiles look silly?  We need
>
>    #define NADA do { } while (0)

IMO "((void)0)" looks nice too.

bye, Roman

