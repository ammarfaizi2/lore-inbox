Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbTESQta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTESQta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:49:30 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:44040 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262157AbTESQt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:49:29 -0400
Date: Mon, 19 May 2003 19:02:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@quark.didntduck.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
Message-ID: <20030519170226.GB983@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3EC82A7D.5090105@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC82A7D.5090105@quark.didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 08:51:09PM -0400, Brian Gerst wrote:
> Convert foo-objs to newer-style foo-y.

The paths looks correct.
But do we really want to go that far, and deprecate the -objs syntax?

> -adfs-objs := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
> +adfs-y := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o

The patch contains a lot of changes like the above - and they
are only relevant if we deprecate the -objs syntax.

Opinions anyone?

	Sam
