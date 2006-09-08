Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWIHK6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWIHK6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 06:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWIHK6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 06:58:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30215 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750788AbWIHK6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 06:58:14 -0400
Date: Fri, 8 Sep 2006 12:58:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols (v2)
Message-ID: <20060908105812.GK25473@stusta.de>
References: <44FFEE5D.2050905@openvz.org> <20060908001325.GA1559@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908001325.GA1559@tuatara.stupidest.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 05:13:25PM -0700, Chris Wedgwood wrote:
> On Thu, Sep 07, 2006 at 02:03:09PM +0400, Kirill Korotaev wrote:
> 
> > At stage 2 modpost utility is used to check modules.  In case of
> > unresolved symbols modpost only prints warning.
> 
> please don't, i get bogus warnings for some drivers when
> cross-compiling, this would create problems for little or no gain

Can you give an example of such a bogus warning?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

