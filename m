Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWJDDOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWJDDOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWJDDOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:14:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161068AbWJDDOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:14:20 -0400
Date: Tue, 3 Oct 2006 20:13:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061003201340.afa7bfce.akpm@osdl.org>
In-Reply-To: <20061003172511.GL3164@in.ibm.com>
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 13:25:11 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> Increasingly the cobbled together boot protocol that
> is bzImage does not have the flexibility to deal
> with booting in new situations.
> 
> Now that we no longer support the bootsector loader
> we have 512 bytes at the very start of a bzImage that
> we can use for other things.
> 
> Placing an ELF header there allows us to retain
> a single binary for all of x86 while at the same
> time describing things that bzImage does not allow
> us to describe.

Seems that the entire kernel effort is an ongoing plot to make my poor
little Vaio stop working.  This patch turns it into a black-screened rock
as soon as it does grub -> linux.  Stock-standard FC5 install, config at
http://userweb.kernel.org/~akpm/config-sony.txt.
