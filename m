Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTFTVq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbTFTVq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:46:58 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:12208 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S264916AbTFTVqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:46:55 -0400
Date: Fri, 20 Jun 2003 17:00:54 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Benoit Beauchamp <benoit.beauchamp@sbcglobal.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 fixdep / cant make *config
In-Reply-To: <000701c33763$7afe1df0$0201a8c0@WIRE>
Message-ID: <Pine.LNX.4.44.0306201659370.26860-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Benoit Beauchamp wrote:

>   HOSTCC  scripts/fixdep
> In file included from /usr/include/netinet/in.h:212,
>                  from scripts/fixdep.c:107:
> /usr/include/bits/socket.h:305:24: asm/socket.h: No such file or directory
> scripts/fixdep.c: In function `use_config':
> scripts/fixdep.c:193: `PATH_MAX' undeclared (first use in this function)
> scripts/fixdep.c:193: (Each undeclared identifier is reported only once
> scripts/fixdep.c:193: for each function it appears in.)
> scripts/fixdep.c:193: warning: unused variable `s'
> scripts/fixdep.c: In function `parse_dep_file':
> scripts/fixdep.c:289: `PATH_MAX' undeclared (first use in this function)
> scripts/fixdep.c:289: warning: unused variable `s'
> make[1]: *** [scripts/fixdep] Error 1
> make: *** [scripts] Error 2

Make sure that /usr/include/asm has a proper set of headers, i.e. it's not 
just a symlink pointing to your current kernel source. google.com will get 
you more information ;)

--Kai


