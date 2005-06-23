Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVFWEYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVFWEYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVFWEYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:24:44 -0400
Received: from iabervon.org ([66.92.72.58]:773 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262050AbVFWEYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:24:41 -0400
Date: Thu, 23 Jun 2005 00:23:10 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42B9E536.60704@pobox.com>
Message-ID: <Pine.LNX.4.21.0506230019440.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Jeff Garzik wrote:

> 5) check in your own modifications (e.g. do some hacking, or apply a patch)
> 
> # go to repo
> $ cd linux-2.6
> 
> # make some modifications
> $ patch -sp1 < /tmp/my.patch
> $ diffstat -p1 < /tmp/my.patch
> 
> # NOTE: add '--add' and/or '--remove' if files were added or removed
> $ git-update-cache <list of all files changed>

There's actually "git add" for when you add a file (if you're actually
developing with git, rather than just applying patching with it). No
script, so far as I can tell, for removing a file, though.

	-Daniel
*This .sig left intentionally blank*

