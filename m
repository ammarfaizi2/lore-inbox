Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314505AbSEXQyI>; Fri, 24 May 2002 12:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314512AbSEXQyH>; Fri, 24 May 2002 12:54:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9212 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314505AbSEXQyG>; Fri, 24 May 2002 12:54:06 -0400
Subject: Re: Compiling 2.2.19 with -O3 flag
From: Robert Love <rml@tech9.net>
To: Marcus Meissner <mm@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205241645.g4OGjbE30934@ns.caldera.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 May 2002 09:54:04 -0700
Message-Id: <1022259244.2638.243.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 09:45, Marcus Meissner wrote:

> > Heh, now that is interesting.
> 
> Not really, -Os implies -O2, cf gcc/toplev.c:

Well, according to Alan -Os outperforms -O2.  So either the code is
smaller _and_ faster - and that is surely interesting - or the code is
_not_ smaller and -Os is a misnomer.  Seems interesting to me.

	Robert Love

