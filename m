Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbTIOUyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTIOUyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:54:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33990 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261559AbTIOUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:54:48 -0400
Date: Mon, 15 Sep 2003 22:51:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: John Bradford <john@grabjohn.com>, alan@lxorguk.ukuu.org.uk,
       davidsen@tmr.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030915205100.GO126@fs.tum.de>
References: <200309150831.h8F8Vir6000839@81-2-122-30.bradfords.org.uk> <3F657931.2050209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F657931.2050209@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 06:32:49PM +1000, Nick Piggin wrote:
>...
> While I like Adrian's patch a lot from a functionality and user
> simplicity point of view, the key to getting it merged is not to 
> increase the complexity of the implementation. The only objections to
> the concept came from people who didn't understand it AFAIK.
>...

My impresion is that much problem comes from the fact that I didn't 
split the patch the first time I sent it.

Most of the oppositon came against the arch/i386/kernel/cpu/{,mtrr/} 
optimizations that are more an eample of how to achive further space 
savings in this scheme but not a required part of this patch.

The main part wasn't non-controversal but it didn't have such a big 
number of opponents.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

