Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSL2RB5>; Sun, 29 Dec 2002 12:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSL2RB5>; Sun, 29 Dec 2002 12:01:57 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:47625 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266637AbSL2RB4>; Sun, 29 Dec 2002 12:01:56 -0500
Date: Sun, 29 Dec 2002 17:10:16 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Rahul Jain <rahul@rice.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb.c has lots of undefined symbols
In-Reply-To: <87hecxfhnf.fsf@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212291709430.14098-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try my patch. http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

> I just decided to make the leap to 2.5, and in the process of compiling,
> I hit a bug: Many of the PCI IDs are defined as .._RADEON_.. instead of
> .._ATI_RADEON_.. as radeonfb.c has them and others aren't even defined
> in any way that I can see. Also, there are a few other undefined symbols
> in there. I don't use console much, so I just disabled the driver, but
> I'm sure some people would appreciate if the driver at least
> compiled. :)

