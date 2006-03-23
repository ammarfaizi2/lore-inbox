Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWCWR7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWCWR7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWCWR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:59:11 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:20368 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S964920AbWCWR7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:59:08 -0500
X-ME-UUID: 20060323175854999.F3F481C0023E@mwinf0101.wanadoo.fr
Message-ID: <4422E171.1040909@worldonline.fr>
Date: Thu, 23 Mar 2006 18:57:05 +0100
From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: fr-fr, en-us
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for
 intelfb
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com> <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Sorry for my very long silence.

For i2c support. I've done it to have a workable tv-out on my hardware. 
It was the main reason  why i ported the driver to kernels 2.6 as i use 
my computer as a set-top-box only connected to a tv. I've it on my own 
tree (very old).
I can send you the code. I did it in a way not accepted by kernel 
reviewers as my tv driver (for chrontel ch7011 chipset) is all in kernel 
space. But it can be a base for a better scheme.

Regards
Sylvain

Dave Airlie a écrit:

>>>This code isn't perfect but I've got no documentation so I cannot
>>>answer some questions on what exactly is going on just yet...
>>>      
>>>
>>Better than nothing, and if it works for digital displays, then that
>>would be great.
>>    
>>
>
>It doesn't support LVDS or DVI yet but I'm hoping to make it go in
>that direction, I've no LVDS h/w, and some chipsets have it integrated
>and some don't, but this is a better basis for future work, and I'll
>have no problems keeping it updated with fixes as they come from the
>X.org driver... I'd like to get at least LVDS support working for
>laptop users with these chipsets, getting DVI working is a bit more
>work as there are external chips that need to be driven over i2c, so
>I'll need to at least add i2c support to the i8xx driver. (I noticed
>Sylvain has done some of this work before)..... I'd like to expose i2c
>buses to userspace anyways....
>
>  
>
>>There's no git tree for the framebuffer layer, I just send updates
>>directly to akpm. Andrew?
>>
>>    
>>
>
>I'd like to keep the git history if possible, so maybe we can pull
>this tree into -mm and I can get it pulled by Linus later.
>
>Regards,
>Dave
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by xPML, a groundbreaking scripting language
>that extends applications into web and mobile media. Attend the live webcast
>and join the prime developer group breaking into this new coding territory!
>http://sel.as-us.falkag.net/sel?cmd=k&kid0944&bid$1720&dat1642
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>  
>



