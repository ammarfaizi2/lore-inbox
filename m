Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTIGTmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTIGTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:42:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24307 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261408AbTIGTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:42:19 -0400
Date: Sun, 7 Sep 2003 21:42:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Peter Daum <gator@cs.tu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
Message-ID: <20030907194209.GJ14436@fs.tum.de>
References: <20030907151422.GX14436@fs.tum.de> <Pine.LNX.4.30.0309072019040.8020-100000@swamp.bayern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0309072019040.8020-100000@swamp.bayern.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 08:38:57PM +0200, Peter Daum wrote:

> Hi Adrian,

Hi Peter,

> Your patch did the trick!

thanks for your report!

Your thoroughly problem description ad testing was the reason why I was 
able to think about this possible reason.

> (Since this looks like a pretty general issue, I guess, that
> means that there were some more problems besides the
> networking-stuff that I stumbled across?)

It's a pretty general issue and althought whatever triggered it for you 
was introduced in 2.4.22, it isn't new.

I'll send a slightly different patch for inclusion in 2.4.23.

> Thanks a bunch,
>                          Peter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

