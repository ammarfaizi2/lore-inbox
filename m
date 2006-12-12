Return-Path: <linux-kernel-owner+w=401wt.eu-S1751056AbWLLGG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWLLGG2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWLLGG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:06:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47773 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbWLLGG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:06:28 -0500
Date: Mon, 11 Dec 2006 22:06:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
Message-Id: <20061211220617.669da2d5.akpm@osdl.org>
In-Reply-To: <20061212145341.a5f335a0.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061211005807.f220b81c.akpm@osdl.org>
	<20061212145341.a5f335a0.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 14:53:41 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> 
> On Mon, 11 Dec 2006 00:58:07 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > Temporarily at
> > 
> > 	http://userweb.kernel.org/~akpm/2.6.19-mm1/
> > 
> > Will appear later at
> > 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/
> > 
> 
> When I use ftp on 2.6.19-mm1, transfered file is always broken.
> like this:
> ==
> [kamezawa@casares ~]$ file ./linux-2.6.19.tar.bz2 (got on 2.6.19-mm1)
> ./linux-2.6.19.tar.bz2: data
> (I confirmed original file was not broken.)

Yes, a couple of people have reported things like this.  Strange. 
test.kernel.org is showing mostly-green.  There's one fsx-linux failure (for
unclear reasons) on one of the x86_64 machines, all the rest are happy.

Which filesystem were you using?

Can you investigate it a bit further please??  reboot, re-download, work
out how the data differs, etc?
