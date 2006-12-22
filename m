Return-Path: <linux-kernel-owner+w=401wt.eu-S1754832AbWLVNoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbWLVNoF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWLVNoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:44:05 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:35226 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbWLVNoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:44:04 -0500
Subject: Re: Kernel BUG
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Rudy Zijlstra <rudy@edsons.demon.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs <nfs@lists.sourceforge.net>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
In-Reply-To: <458BC8AE.2030507@edsons.demon.nl>
References: <458BC8AE.2030507@edsons.demon.nl>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 14:42:00 +0100
Message-Id: <1166794920.32117.42.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 12:59 +0100, Rudy Zijlstra wrote:
> Hi,
> 
> I have a system where whenever i trigger a ongoing consistent NFS load i 
> get the following kernel BUG:
> 
> ----------
> kernel BUG at mm/truncate.c:311!

Lotsa changes there:
try these:
 http://client.linux-nfs.org/Linux-2.6.x/2.6.19/linux-2.6.19-NFS_ALL.dif

And:
  http://lkml.org/lkml/2006/12/19/279



