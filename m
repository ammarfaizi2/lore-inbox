Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUL0UcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUL0UcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUL0UcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:32:10 -0500
Received: from mail.linicks.net ([217.204.244.146]:4356 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261980AbUL0UcF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:32:05 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: About NFS4 in kernel 2.6.9
Date: Mon, 27 Dec 2004 20:31:59 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412272031.59918.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for your help,
> I´ve checked what Jan said, and in .config is NFS_FS=y. When i do
> modprobe sunrpc shows me:

> [root@laca01 ~]# modprobe sunrpc
> FATAL: Module sunrpc not found.
> FATAL: Error running install command for sunrpc

> It´s really annoyng :)

Diego,

Have a look in /boot/ (I guess) fedora will supply the .config file used to 
build the stock kernel.  Simply copy that to your 2.6.9 src tree and issue a

 > make oldconfig

To pick up the options of the new tree.  That should also include all the 
modules etc. you already had running nfsd/nfs.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
