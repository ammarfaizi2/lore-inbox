Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWHYKh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWHYKh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWHYKh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:37:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43275 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932455AbWHYKhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:37:55 -0400
Date: Fri, 25 Aug 2006 12:37:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060825103754.GW19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org> <20060824160926.GM19810@stusta.de> <20060824164752.GC5205@martell.zuzino.mipt.ru> <20060824170709.GO19810@stusta.de> <Pine.LNX.4.61.0608250806560.7912@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608250806560.7912@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:07:37AM +0200, Jan Engelhardt wrote:
> >
> >There's e.g. no reason to ask all users whether they want to compile all 
> >I/O schedulers into their kernel.
> >
> The users that do not know how to handle it should not be compiling a 
> kernel. If in doubt, they should read the help texts and follow the "If 
> unsure" clause listed there.

If your distribution ships 2.6.x and your hardware is not supported 
before 2.6.x+1 you need your own kernel.

The expectation "only kernel hackers don't use distribution kernels" is 
wrong in too many cases.

"System administrator" is a target audience of the kernel configuration, 
and we should make it as easy as possible for such people to compile 
their own kernel.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

