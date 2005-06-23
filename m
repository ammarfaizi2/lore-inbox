Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVFWCNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVFWCNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVFWCNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:13:19 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:25777
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262013AbVFWCIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:08:54 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 22:08:35 -0400
User-Agent: KMail/1.8
References: <42B9E536.60704@pobox.com>
In-Reply-To: <42B9E536.60704@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222208.36341.kwall@kurtwerks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 18:24, Jeff Garzik enlightened us thusly:
> Things in git-land are moving at lightning speed, and usability has
> improved a lot since my post a month ago: 
> http://lkml.org/lkml/2005/5/26/11
>
>
>
> 1) installing git
>
> git requires bootstrapping, since you must have git installed in order
> to check out git.git (git repo), and linux-2.6.git (kernel repo).  I
> have put together a bootstrap tarball of today's git repository.
>
> Download tarball from:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
>
> tarball build-deps:  zlib, libcurl, libcrypto (openssl)
>
> install tarball:  unpack && make && sudo make prefix=/usr/local install
>
> jgarzik helper scripts, not in official git distribution:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
>
> After reading the rest of this document, come back and update your copy
> of git to the latest:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
>
>
> 2) download a linux kernel tree for the very first time
>
> $ mkdir -p linux-2.6/.git
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> \          <- word-wrapped backslash; sigh
>      .git/

Suggest noting that this first rsync can take quite awhile, modulo
available bandwidth, because one is bootstrapping or populating the 
repository (my terminology might be incorrect).

Kurt
