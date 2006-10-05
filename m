Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWJEEMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWJEEMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWJEEMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:12:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28896 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750746AbWJEEMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:12:54 -0400
Message-ID: <4524862A.7080306@zytor.com>
Date: Wed, 04 Oct 2006 21:12:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>	<20061003172511.GL3164@in.ibm.com>	<20061003201340.afa7bfce.akpm@osdl.org> <m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> Ugh.  I just tested this with a grub 0.97-5 from what I assume is a
> standard FC5 install (I haven't touched it) and the kernel boots.
> I only have a 64bit user space on that machine so init doesn't
> start but I get the rest of the kernel messages.
> 
> There were several testers working at redhat so a pure redhat
> incompatibility would be a surprise.
> 
> I don't think the formula is a simple grub+bzImage == death.
> 
> There is something more subtle going on here.  
> 
> I'm not certain where to start looking.  Andrew it might help if we
> could get the dying binary just in case some weird compile or
> processing problem caused insanely unlikely things like the multiboot
> binary to show up in your grub install.  I don't think that is it,
> but it should allow us to rule out that possibility.
> 

I would try running it in a more memory-constrained environment.

	-hpa
