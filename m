Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDDPCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDDPCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDDPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:02:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40461 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750703AbWDDPCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:02:41 -0400
Date: Tue, 4 Apr 2006 17:02:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix unneeded rebuilds in drivers/media/video after moving source tree
Message-ID: <20060404150233.GA10608@mars.ravnborg.org>
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org> <442C4469.1040408@gmx.net> <20060331152226.GB8992@mars.ravnborg.org> <4431A338.3000709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4431A338.3000709@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This fixes some uneeded rebuilds under drivers/media/video after moving
> the source tree. The makefiles used $(src) and $(srctree) for include
> paths, which is unnecessary. Changed to use relative paths.
> 
> Compile tested, produces byte-identical code to the previous makefiles.

Thanks, applied both.
Did similar changes in cx88 + some ppc code.

	Sam
