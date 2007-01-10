Return-Path: <linux-kernel-owner+w=401wt.eu-S964907AbXAJPUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbXAJPUL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbXAJPUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:20:11 -0500
Received: from main.gmane.org ([80.91.229.2]:58160 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964907AbXAJPUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:20:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: "svc: unknown version (3)" when =?utf-8?b?Q09ORklHX05GU0RfVjQ9eQ==?=
Date: Wed, 10 Jan 2007 15:15:02 +0000 (UTC)
Message-ID: <loom.20070110T155948-40@post.gmane.org>
References: <367964923.02447@ustc.edu.cn> <20070105024226.GA6076@mail.ustc.edu.cn> <17828.33075.145986.404400@notabene.brown> <368438638.13038@ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.52.61.133 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.1) Gecko/20061205 Iceweasel/2.0.0.1 (Debian-2.0.0.1+dfsg-1))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fengguang Wu <fengguang.wu <at> gmail.com> writes:

> root ~# mount localhost:/suse /mnt
> [  132.678204] svc: unknown version (3 for prog 100227, nfsd)
> 
> I've confirmed that 2.6.20-rc2-mm1, 2.6.20-rc3-mm1, 2.6.19-rc6-mm1 all
> have this warning, while 2.6.17-2-amd64 is good.

I get the same log messages here with 2.6.19.  I also noticed the following
messages when starting rpc.nfsd:

nfsd[1287]: nfssvc: writting fds to kernel failed: errno 0 (Success) 
nfsd[1287]: nfssvc: writting fds to kernel failed: errno 0 (Success) 

These messages appeared with kernel 2.6.19 too.  I however don't know if
this could be related to the other messages.
I use nfs-utils 1.0.10 on Debian Etch.

Arnaud Giersch


