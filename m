Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVFVW4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVFVW4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVFVWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:52:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262464AbVFVWkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:40:41 -0400
Date: Wed, 22 Jun 2005 18:40:03 -0400
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Message-ID: <20050622224003.GA21298@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9E536.60704@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
 > 
 > Things in git-land are moving at lightning speed, and usability has 
 > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
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

<blatant self-promotion>
daily snapshots (refreshed once an hour) are available at:
http://www.codemonkey.org.uk/projects/git-snapshots/git/
</blatant self-promotion>

 > tarball build-deps:  zlib, libcurl, libcrypto (openssl)
 > 
 > install tarball:  unpack && make && sudo make prefix=/usr/local install

the sudo thing isn't necessary. make install by itself installs it
in ~/bin/ just fine.

 > After reading the rest of this document, come back and update your copy 
 > of git to the latest:
 > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git

See above, which allows you to skip this step ;)

		Dave

