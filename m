Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWFPRTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWFPRTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWFPRTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 13:19:19 -0400
Received: from kanga.kvack.org ([66.96.29.28]:59588 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751056AbWFPRTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 13:19:19 -0400
Date: Fri, 16 Jun 2006 14:20:02 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Older git hooks for linux-2.4
Message-ID: <20060616172002.GA3580@dmt>
References: <26721.1150438597@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26721.1150438597@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 04:16:37PM +1000, Keith Owens wrote:
> rsync rsync://rsync.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/
> 
> has hooks that do not match the current git template hooks.
> 
> git-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/
> 
> appears to install the hooks from the local template directory, rather
> than cloning from the remote repository.  Is the difference between the
> rsync and git-clone commands an expected behaviour?

Think so, git-clone does git-init-db, without specifying template directory.

       git-init-db [--template=<template_directory>] [--shared]

OPTIONS
       --template=<template_directory>
              Provide  the  directory  from  which templates will be used. The
              default template directory is /usr/share/git-core/templates.

> And should the
> hooks in /pub/scm/linux/kernel/git/marcelo/linux-2.4.git be updated to
> match the current git templates?

Yep.. thanks.
