Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWDTDtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDTDtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 23:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDTDtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 23:49:17 -0400
Received: from xenotime.net ([66.160.160.81]:37565 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751168AbWDTDtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 23:49:16 -0400
Date: Wed, 19 Apr 2006 20:51:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060419205141.63298a26.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Apr 2006 17:26:16 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> Here is a batch of kconfig (and also some kbuild related) patches. The 
> first four patches I'd like to see to go into 2.6.17 if possible. Although 
> I'm quite confident about the remaining patches, a bit more testing can't 
> hurt.
> 
> Some comments about the most interesting aspects from a user perspective 
> for these patches:
> 
> Now it's possible to do something like "vi .config; make" and be 
> reasonably certain it does the right thing, before especially kbuild 
> related config changes were not correctly picked up by make and required 
> an explicit "make oldconfig".

[snip]

> Another interesting feature are the xconfig changes, it supports now a 
> search option like menuconfig and the help output links to other symbols, 
> so one can basically browse through the kconfig info. The latter is still 
> a bit experimental, so it's only visible if the debug info option is 
> enabled.

Hi Roman,
I have a few questions about this patch series.  All of them are
about using *config (i.e., this is not a patch review).

~~~~~
Subject: [PATCH 12/19] kconfig: add symbol option config syntax

Do we have any examples of this?  (where)
~~~~~
Subject: [PATCH 14/19] kconfig: Add search option for xconfig

How do I search?  I don't see it in the menu or any Help for it.
~~~~~
Subject: [PATCH 15/19] kconfig: finer customization via popup menus

How?  documentation?
~~~~~
Subject: [PATCH 16/19] kconfig: create links in info window

How?  what does link look like?  are there any in the current
Kconfig menus?  I'd like to see one (or several).
~~~~~
Subject: [PATCH 17/19] kconfig: jump to linked menu prompt

I'd like to see this too.  Where can I see it?
~~~~~


Thanks,
---
~Randy
