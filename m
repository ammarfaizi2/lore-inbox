Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbULBAuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbULBAuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbULBAuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:50:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4624 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261529AbULBAuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:50:24 -0500
Date: Thu, 2 Dec 2004 01:50:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Laufer <paul@laufernet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] OSS sb_card.c: no need to include mca.h
Message-ID: <20041202005022.GF5148@stusta.de>
References: <20041201215012.GW2650@stusta.de> <1101944325.30819.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101944325.30819.71.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 11:38:47PM +0000, Alan Cox wrote:
> On Mer, 2004-12-01 at 21:50, Adrian Bunk wrote:
> > I didn't find any reason why this file includes mca.h .
> > 
> 
> It certainly used to need it to build MCA bus soundblaster support.
> Whether it still does in 2.6 I don't know. I assume you tried an MCA
> build of OSS ?

Yes, I did.

And a

  grep -ri mca sound/oss/*

only found false positives (nmcard_list, numcards).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

