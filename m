Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWAIF7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWAIF7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWAIF7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:59:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6926 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932503AbWAIF7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:59:24 -0500
Date: Mon, 9 Jan 2006 06:58:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git in scripts/setlocalversion
Message-ID: <20060109055850.GA8011@mars.ravnborg.org>
References: <20060104194203.GA2359@lsrfire.ath.cx> <2cd57c900601081947l24598adm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900601081947l24598adm@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 11:47:12AM +0800, Coywolf Qi Hunt wrote:
> 2006/1/5, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> > Currently scripts/setlocalversion is a Perl script that tries to figure
> > out the current git commit ID of a repo without using git.  It also
> > imports Digest::MD5 without using it and generally is too big for the
> > small task it does. :]  And it always reports a git ID, even when the
> > HEAD is tagged -- this is a bug.
> >
> > This patch replaces it with a Bourne Shell script that uses git
> > commands to do the same.  I can't come up with a scenario where someone
> > would use a git repo and refuse to install git core at the same time,
> > so I think it's reasonable to assume git is available.
 
> You didn't update the caller in the top Makefile, but that's ok.

It's fixed in my tree.

	Sam
