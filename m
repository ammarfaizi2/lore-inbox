Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVG1VVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVG1VVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVG1VVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:21:12 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:40856 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262271AbVG1VTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:19:21 -0400
Date: Thu, 28 Jul 2005 23:20:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: blaisorblade@yahoo.it
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net
Subject: Re: kconfig: trivial cleanup
Message-ID: <20050728212017.GA8612@mars.ravnborg.org>
References: <20050728155627.14CD51ADBD@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728155627.14CD51ADBD@zion.home.lan>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 05:56:25PM +0200, blaisorblade@yahoo.it wrote:
> Replace all menu_add_prop mimicking menu_add_prompt with the latter func. I've
> had to add a return value to menu_add_prompt for one usage.
> 
> I've rebuilt scripts/kconfig/zconf.tab.c_shipped by hand to reflect changes
> in the source (I've not the same Bison version so regenerating it wouldn't
> have been not a good idea), and compared it with what Roman itself did some
> time ago, and it's the same.
> 
> So I guess this can be finally merged.

I've applied the aptch - despite the strange formatting. See menu.c.

	Sam
