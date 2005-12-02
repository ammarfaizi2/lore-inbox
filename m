Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVLBACR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVLBACR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVLBACR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:02:17 -0500
Received: from pat.uio.no ([129.240.130.16]:26287 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932556AbVLBACQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:02:16 -0500
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 19:02:01 -0500
Message-Id: <1133481721.9597.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 23:47 +0100, JaniD++ wrote:
> Hello, list,
> 
> I get this after upgrade from 2.6.14.2
> 
> [root@dy-xeon-1 etc]# adduser someuser
> adduser: unable to lock password file
> [root@dy-xeon-1 etc]#
> 
> I use nfsroot!

I'm seeing no trouble with locking on 2.6.15-rc3 (with or without the
-onolock option). Could you please use 'strace' to get a dump of what
adduser is failing on?

Cheers,
 Trond

