Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSGOLQw>; Mon, 15 Jul 2002 07:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSGOLQv>; Mon, 15 Jul 2002 07:16:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:13816 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317434AbSGOLQu>; Mon, 15 Jul 2002 07:16:50 -0400
Subject: Re: [PATCH] 2.5.25 Hotplug CPU boot changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
       Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
       ralf@gnu.org, paulus@samba.org, anton@samba.org, schwidefsky@de.ibm.com,
       ak@suse.de, davem@redhat.com
In-Reply-To: <20020715090336.19E604130@lists.samba.org>
References: <20020715090336.19E604130@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 13:29:01 +0100
Message-Id: <1026736141.13885.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 09:58, Rusty Russell wrote:
> The following patches change boot sequence, and once Linus releases
> 2.5.26, I'll be updating and sending them.  This will break every SMP
> architecture (patch for x86 below, and I have a patch for PPC32).
>			printk("ksoftirqd for %i failedn", hotcpu);

Q: What prevents a CPU coming up -during- an MTRR change once the rest
of the cpu hot plugging is present ?

