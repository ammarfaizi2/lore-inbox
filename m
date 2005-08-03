Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVHCXxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVHCXxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVHCXxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:53:40 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:2973 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261641AbVHCXxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:53:38 -0400
Date: Thu, 4 Aug 2005 01:56:39 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       Bodo Eggert <7eggert@gmx.de>, Gene Heskett <gene.heskett@verizon.net>,
       "H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
       Puneet Vyas <vyas.puneet@gmail.com>,
       Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
Message-ID: <20050803235639.GC6223@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
	Sean Bruno <sean.bruno@dsl-only.net>,
	Lee Revell <rlrevell@joe-job.com>, Bodo Eggert <7eggert@gmx.de>,
	Gene Heskett <gene.heskett@verizon.net>,
	"H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
	Puneet Vyas <vyas.puneet@gmail.com>,
	Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
References: <200508022332.21380.jesper.juhl@gmail.com> <200508032251.07996.jesper.juhl@gmail.com> <Pine.LNX.4.58.0508031400390.3258@g5.osdl.org> <200508032328.07727.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508032328.07727.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.229.180
Subject: Re: Documentation - how to apply patches for various trees
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 Jesper Juhl wrote:
> +How do I feed a patch/diff file to `patch'?
> +---
> + This (as usual with Linux and other UNIX like operating systems) can be
> +done in several different ways.
> +In all the examples below I feed the file (in uncompressed form) to patch
> +via stdin using the following syntax:
> +	patch -p1 < path/to/patch-x.y.z

I think you should mention the -s flag. Given the size of an
average kernel patch it is otherwise very likely that errors scroll
away unnoticed.

OTOH you might also want to add a mention of lsdiff and diffstat.

Johannes
