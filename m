Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbTC1K6r>; Fri, 28 Mar 2003 05:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262911AbTC1K6r>; Fri, 28 Mar 2003 05:58:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43928 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262908AbTC1K6q>;
	Fri, 28 Mar 2003 05:58:46 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 28 Mar 2003 12:10:01 +0100 (MET)
Message-Id: <UTC200303281110.h2SBA1L24473.aeb@smtp.cwi.nl>
To: greg@kroah.com, zippel@linux-m68k.org
Subject: Re: 64-bit kdev_t - just for playing
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman, Your questions are misguided.
A larger dev_t is infrastructure.
A sand road that is turned into an asphalt road.

Nobody has to use this improved infrastructure.
But many uses are conceivable.

Long ago I reserved 2^40 values for dynamically
assigned anonymous devices. Convenient, a very
small fraction of the available space.

I can imagine that there will be people wanting
to take part of the available space for a universal
hash of disk serial number or partition label or
I don't know what, so that devices are addressable
by content instead of path.

A lot of room can be put to many uses.

Andries
