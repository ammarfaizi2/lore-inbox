Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWIVMcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWIVMcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWIVMcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:32:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:61414 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932378AbWIVMcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:32:42 -0400
From: Andi Kleen <ak@suse.de>
To: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH -mm] x86_64 mm generic getcpu syscall fix
Date: Fri, 22 Sep 2006 14:19:09 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060919012848.4482666d.akpm@osdl.org> <4513CD55.4070208@fr.ibm.com>
In-Reply-To: <4513CD55.4070208@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221419.09248.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 13:47, Cedric Le Goater wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/
> 
> while working on a new syscall, i've noticed that the getcpu
> patch x86_64-mm-generic-getcpu-syscall.patch does not increase
> NR_syscalls. shouldn't it ? 

Yes. Fixed thanks.

-Andi
