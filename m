Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWDEWuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWDEWuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWDEWup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:50:45 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:19083 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932109AbWDEWup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:50:45 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200604052246.k35Mkl6L010288@wildsau.enemy.org>
Subject: Re: Q on audit, audit-syscall
In-Reply-To: <20060405223052.GE14724@sorel.sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 6 Apr 2006 00:46:47 +0200 (MET DST)
CC: Valdis.Kletnieks@vt.edu, Kyle Moffett <mrmacman_g4@mac.com>,
       Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Herbert Rosmanith (kernel@wildsau.enemy.org) wrote:
> > anyway, the manpage describes how auditd/libaudit works - not how it has been
> > implemented/how it communicates with the kernel.
> > I want to know how it works "under the hood", not just how to use it.
> 
> Then grab the source, and read its READMEs.

good point. I was reading netlink.c and libaudit.c. obviously the wrong
place ;-)
 
> > LSM depends
> > on CONFIG_AUDIT* (this is correct, isn't it?)
> 
> No.
> 
