Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVKENoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVKENoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 08:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKENoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 08:44:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2568 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750799AbVKENoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 08:44:11 -0500
Date: Sat, 5 Nov 2005 14:44:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
Message-ID: <20051105134409.GF5368@stusta.de>
References: <436C7E77.3080601@ed-soft.at> <20051105122958.7a2cd8c6.khali@linux-fr.org> <436CB162.5070100@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436CB162.5070100@ed-soft.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 02:19:30PM +0100, Edgar Hucek wrote:

> Hi.

Hi Edgar,

> Sorry for not posting my Name.
> 
> Maybe you don't understand what i wanted to say or it's my bad english.
> The ipw2200 driver was only an example. I had also problems with, vmware,
> unionfs...
> What i mean ist, that kernel developers make incompatible changes to the 
> header
> files, change structures, interfaces and so on. Which makes the kernel 
> releases
> incompatible.

you've already been given a pointer to the                               
Documentation/stable_api_nonsense.txt document in the kernel sources 
that explains these issues.

> There are several reasons why modules are not in the mainline kernel and 
> will never
> get there. So saying, bring modules to the kernel is wrong.

It's not wrong.

Every vendor of any kind of software will tell you A is supported and 
B is not supported.

It's a consensus among the Linux kernel developers that the Linux kernel 
does not support a stable API for external modules.

You don't have to like this decision, but stable_api_nonsense.txt 
explains it.

If you dislike this decision, there are several other operating systems 
whose vendors do offer a stable API for external modules.

> The right way would be to take care of defined interfaces, header files, 
> and so on.
> Otherwise you could only say the kernel 2.6.14 is only compatible to 
> 2.6.14.X and
> you there is no stable 2.6 mainline kernel.

The 2.6 is a stable kernel series in the sense that it doesn't crash 
very often.

2.6.14 is not API-compatible with 2.6.15.

But this has always been this way, the new development model only brings 
more API changes than the previous development models.

> I think it's also no task for the user, to search the net why external 
> driver xyz not
> works with a new kernel ( because of incompatibilties ). Basicly in new 
> kernel there
> could be a chance for the user a driver works better, because a bug was 
> fixed in the
> kernel.
>...

I do agree, this is not a task for the user.

It's a task for the vendors of the external modules.

> cu
> 
> ED.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

