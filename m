Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313943AbSEATf1>; Wed, 1 May 2002 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313946AbSEATf0>; Wed, 1 May 2002 15:35:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51401 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313943AbSEATf0>;
	Wed, 1 May 2002 15:35:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 1 May 2002 21:34:59 +0200 (MEST)
Message-Id: <UTC200205011934.g41JYxB23532.aeb@smtp.cwi.nl>
To: greg@kroah.com, sydelko@ecn.purdue.edu
Subject: Re: 2.5.1[012] compile fix under drivers/usb/storage
Cc: linux-kernel@vger.kernel.org, torvalds@penguin.transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Wed, May 01, 2002 at 09:58:57AM -0500, Andrew T Sydelko wrote:
    > 
    > The following patch fixes compilation problems due to structure changes.
    > The patch applies against 2.5.1[012].
    > 
    > drivers/usb/storage/datafab.c
    > drivers/usb/storage/jumpshot.c

    I don't think this is the proper fix for this code (due to highmem
    issues).  Could you please work with the usb-storage author and
    maintainer to get this fixed.

    thanks,

    greg k-h

It was already fixed in sddr09.c, so the code can be copied from there.

(Indeed, the code was cloned from there, and identical copies occur
in several drivers. I made raw_bulk.c and smartmedia.c to hold the
stuff that is repeated today.)

Andries
