Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVA0Kjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVA0Kjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVA0KiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:38:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58636 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262558AbVA0KUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:20:15 -0500
Date: Thu, 27 Jan 2005 11:20:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: dtor_core@ameritech.net, Christoph Hellwig <hch@infradead.org>,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050127102008.GB28047@stusta.de>
References: <20050125195918.460f2b10.khali@linux-fr.org> <20050126003927.189640d4@zanzibar.2ka.mipt.ru> <20050125224051.190b5ff9.khali@linux-fr.org> <20050126013556.247b74bc@zanzibar.2ka.mipt.ru> <20050126101434.GA7897@infradead.org> <1106737157.5257.139.camel@uganda> <d120d5000501260600fb8589e@mail.gmail.com> <1106757528.5257.221.camel@uganda> <20050126181941.GC5297@stusta.de> <20050126222743.1e0a29ff@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126222743.1e0a29ff@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 10:27:43PM +0300, Evgeniy Polyakov wrote:
>...
> I greatly appreciate your comments, and they were addressed.
> Part of exported symbols are unexported, patch is just waiting to be sent,

Ah, sorry. I only saw that the patch I sent two months ago still 
applies completely (except for an unrelated context change).

> but I do not agree with dscore rename. I just do not understand it's advantage.

It is only a small cosmetic thing:
If there's only one object file in a module, a renaming in the Makefile 
is superfluous - you can simply rename the source file

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

