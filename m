Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWJDFhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWJDFhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWJDFhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:37:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964886AbWJDFhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:37:52 -0400
Date: Tue, 3 Oct 2006 22:37:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061003223720.94c54581.akpm@osdl.org>
In-Reply-To: <20061004042850.GA27149@in.ibm.com>
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<20061004042850.GA27149@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 00:28:50 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > Seems that the entire kernel effort is an ongoing plot to make my poor
> > little Vaio stop working.  This patch turns it into a black-screened rock
> > as soon as it does grub -> linux.  Stock-standard FC5 install, config at
> > http://userweb.kernel.org/~akpm/config-sony.txt.
> 
> Hi Andrew,
> 
> Right now I don't have access to my test machine.  Tomorrow morning,
> very first thing I am going to try it out with your config file.
> 
> This patch just adds and ELF header to bzImage which is not even used
> by grub.
> 
> So without this patch you are able to boot the kernel on your laptop?

With your other 11 patches applied and not this one, it boots OK.

With this patch applied and not the other eleven applied: no-compile.

With all 12 applied: crash.
