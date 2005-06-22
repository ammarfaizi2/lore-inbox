Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVFVW4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVFVW4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVFVWxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:53:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:60592 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261175AbVFVWrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:47:08 -0400
Message-ID: <42B9EA67.1040407@pobox.com>
Date: Wed, 22 Jun 2005 18:47:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com>
In-Reply-To: <20050622224003.GA21298@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
>  > 
>  > Things in git-land are moving at lightning speed, and usability has 
>  > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
>  > 
>  > 
>  > 
>  > 1) installing git
>  > 
>  > git requires bootstrapping, since you must have git installed in order 
>  > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
>  > have put together a bootstrap tarball of today's git repository.
>  > 
>  > Download tarball from:
>  > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> 
> <blatant self-promotion>
> daily snapshots (refreshed once an hour) are available at:
> http://www.codemonkey.org.uk/projects/git-snapshots/git/
> </blatant self-promotion>
> 
>  > tarball build-deps:  zlib, libcurl, libcrypto (openssl)
>  > 
>  > install tarball:  unpack && make && sudo make prefix=/usr/local install
> 
> the sudo thing isn't necessary. make install by itself installs it
> in ~/bin/ just fine.

Clearly this does not work if installing in /usr/local, as I and others 
do (and as the example shows).


>  > After reading the rest of this document, come back and update your copy 
>  > of git to the latest:
>  > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> 
> See above, which allows you to skip this step ;)

huh?  Nothing allows you to skip that step.  Regardless of when you suck 
the tarball, even from your snapshots, the users should not skip this step.

	Jeff


