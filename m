Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSGQT16>; Wed, 17 Jul 2002 15:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSGQT16>; Wed, 17 Jul 2002 15:27:58 -0400
Received: from ns.suse.de ([213.95.15.193]:52484 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316548AbSGQT15>;
	Wed, 17 Jul 2002 15:27:57 -0400
Date: Wed, 17 Jul 2002 21:30:56 +0200
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] agpgart changes for 2.5.26
Message-ID: <20020717213056.I18170@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20020717183615.GB9589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717183615.GB9589@kroah.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 11:36:15AM -0700, Greg KH wrote:
 > Hi,
 > 
 > These changesets have the latest agpgart code from the -dj tree, and
 > I've tried to rename the files to something that makes more sense.
 > 
 > 
 > Pull from:  http://linuxusb.bkbits.net/agpgart-2.5
 > 
 >  drivers/char/agp/agp.h               |  348 +-
 >  drivers/char/agp/ali.c               |  265 ++
 >  drivers/char/agp/amd.c               |  408 +++
 >  drivers/char/agp/Config.help         |   88 
 >  drivers/char/agp/Config.in           |   14 
 >  drivers/char/agp/frontend.c          | 1086 ++++++++
 >  drivers/char/agp/hp.c                |  394 +++
 >  drivers/char/agp/i460.c              |  595 ++++
 >  drivers/char/agp/i810.c              |  594 ++++
 >  drivers/char/agp/i8x0.c              |  726 +++++
 >  drivers/char/agp/Makefile            |   35 
 >  drivers/char/agp/sis.c               |  142 +
 >  drivers/char/agp/sworks.c            |  626 ++++
 >  drivers/char/agp/via.c               |  151 +

Linus last comment mentioned via-agp.c, and the likes,
which I did in my tree, but haven't put up a diff yet.
I could dig those out for you, but you could probably
'mv' them faster than I can chunk up the diff into pieces.

        Dave
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
