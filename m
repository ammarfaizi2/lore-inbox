Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSEASS5>; Wed, 1 May 2002 14:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313865AbSEASS4>; Wed, 1 May 2002 14:18:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61337 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313862AbSEASSz>;
	Wed, 1 May 2002 14:18:55 -0400
Date: Wed, 1 May 2002 14:18:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Bob_Tracy <rct@gherkin.frus.com>
cc: system_lists@nullzone.org, linux-kernel@vger.kernel.org
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
In-Reply-To: <m172xYI-0005khC@gherkin.frus.com>
Message-ID: <Pine.GSO.4.21.0205011417230.12640-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 May 2002, Bob_Tracy wrote:

> Confirmed on a 2.5.11 system as well.  Talk about your basic heart
> attack!  I'd just installed Postfix and found that I couldn't access
> any of the directories under /var/spool/postfix.  Fortunately (?),
> I've got older kernels to fall back on, and that's one of the hazards
> of running on the bleeding edge I reckon.
> 
> Oh yeah...  ext2 filesystem.  I think this bug is at least mostly
> independent of the filesystem type.

Yes, it is.  Look for the patch I've posted yesterday (subject was
something like "[PATCH] missing checks", IIRC).

