Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUFUOZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUFUOZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 10:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUFUOZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 10:25:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4256 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266248AbUFUOZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 10:25:15 -0400
Date: Mon, 21 Jun 2004 10:25:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Eric BEGOT <eric_begot@yahoo.fr>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.7-mm1
In-Reply-To: <40D6CAF0.2020402@yahoo.fr>
Message-ID: <Xine.LNX.4.44.0406211024300.23695-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, Eric BEGOT wrote:

> I can't compile 2.6.7-mm1. here are the errors :
> 
> CC      security/selinux/hooks.o
> 
> security/selinux/hooks.c:4129: error: `selinux_netlink_send' undeclared here (not in a function)
> 
> security/selinux/hooks.c:4129: error: initializer element is not constant
> 
> security/selinux/hooks.c:4129: error: (near initialization for `selinux_ops.netlink_send')
> 
> security/selinux/hooks.c:4130: error: `selinux_netlink_recv' undeclared here (not in a function)
> 
> security/selinux/hooks.c:4130: error: initializer element is not constant
> 
> security/selinux/hooks.c:4130: error: (near initialization for `selinux_ops.netlink_recv')
> 
> make[2]: *** [security/selinux/hooks.o] Error 1
> 
> make[1]: *** [security/selinux] Error 2
> 
> make: *** [security] Error 2
> 
> 
> With the same config, the 2.6.7 compiles perfectly. I join my .config.

Works ok for me.  What arch are you using?

Also, didn't see any attached config.


- James
-- 
James Morris
<jmorris@redhat.com>



