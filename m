Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267895AbUHETHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267895AbUHETHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUHETEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:04:55 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:407 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267895AbUHETCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:02:47 -0400
Date: Thu, 5 Aug 2004 21:04:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Giuliano Pochini <pochini@shiny.it>,
       kumar.gala@freescale.com, tnt@246tNt.com,
       linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040805190414.GA7485@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Olaf Hering <olh@suse.de>, Giuliano Pochini <pochini@shiny.it>,
	kumar.gala@freescale.com, tnt@246tNt.com,
	linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net> <20040805180025.GA20390@suse.de> <20040805181425.GD555@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805181425.GD555@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 11:14:25AM -0700, Tom Rini wrote:
> 
> I mistook AFLAGS for being always invoked with gas, which is not the
> case.

Correct, AFLAGS is kbuild internal. AFLAGS is used only for .S -> .o
and for .S -> .s


>Lets do the following:

Yup - looks better with cpu-as-

	Sam
