Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUHaPOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUHaPOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268686AbUHaPOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:14:04 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:47170 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268710AbUHaPMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:12:23 -0400
Message-ID: <9ae345c00408310812212e371e@mail.gmail.com>
Date: Tue, 31 Aug 2004 18:12:20 +0300
From: Yuval Turgeman <yuvalt@gmail.com>
Reply-To: Yuval Turgeman <yuvalt@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Searching parameters in menuconfig
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0408311427110.981@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9ae345c0040831005257c245da@mail.gmail.com> <Pine.LNX.4.61.0408311427110.981@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 16:33:36 +0200 (CEST), Roman Zippel
<zippel@linux-m68k.org> wrote:

> Andrew already commented on the coding style, so I can skip that.

Yeah sorry about that... I didn't read the CodingStyle doc... I'll pay
more attention to it from now on.

> You get to this information easier by iterating over the properties
> attached to a symbol (sym->prop) and a symbol can have multiple menu
> prompts, you show only the first one (which might not be the right one)
> and sym->prop->text might not even be a menu prompt at all.

Ok, I wasn't aware that a symbol could be located in several submenus
- I just tried to follow the build_conf routine.

> It would be nice to actually make it really useful, by first building a
> list of found symbols (and possibly allow wildcards for searching) and
> generate a menu of this. After a symbol is selected, build a new menu with
> all the prompts, which could also include the option to change parent
> symbols.

Yeah I tought about it also - I guess I'll try to implement this soon.  
The usability of the search can be improved a lot... this was just a
tiny prototype to help me find the parameter i was missing. :-)
Thanks!

-- 
Yuval Turgeman
