Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWHWUFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWHWUFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWHWUFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:05:33 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:65243 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965182AbWHWUFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:05:20 -0400
Date: Wed, 23 Aug 2006 16:05:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Eric Paris <eparis@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@tycho.nsa.gov,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] SELinux: 3/3 convert sbsec semaphore to a mutex
In-Reply-To: <1156362637.6662.51.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608231605120.5728@d.namei>
References: <1156362637.6662.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, Eric Paris wrote:

> This patch converts the semaphore in the superblock security struct to a
> mutex.  No locking changes or other code changes are done.
> 
> This is being targeted for 2.6.19
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
