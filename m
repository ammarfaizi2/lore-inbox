Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUFQSHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUFQSHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUFQSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:07:03 -0400
Received: from ceiriog1.demon.co.uk ([194.222.75.230]:22657 "EHLO
	ceiriog1.demon.co.uk") by vger.kernel.org with ESMTP
	id S261396AbUFQSHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:07:01 -0400
Subject: Re: Irix NFS servers, again :-)
From: Peter Wainwright <prw@ceiriog1.demon.co.uk>
To: David Rees <drees@greenhydrant.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <40D163C8.30507@greenhydrant.com>
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
	 <40D163C8.30507@greenhydrant.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087494267.3677.9.camel@ceiriog1.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Jun 2004 18:44:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 10:26, David Rees wrote:

> 
> As I understand it the real problem is actually in glibc.  I have to 
> double check, but I think the software which showed this bug when I 
> experienced it on FC2 was statically linked with an older version of 
> glibc.  I can't seem to reproduce it using `ls` which I remember being 
> able to last time I had the problem so that would explain it.  What 
> software showed the problem for you?

The Gnome configuration daemon, gconfd-2. My desktop configuration
reverted to the default because this program could not find
~/.gconf/apps/panel/profiles/default on an NFS-mounted home
directory.

Peter Wainwright


> 
> See this message from the nfs list.  There is more data in the archives 
> if you look.
> http://marc.theaimsgroup.com/?l=linux-nfs&m=105158098101612&w=2
> 
> -Dave
