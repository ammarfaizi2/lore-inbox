Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288478AbSAIDx0>; Tue, 8 Jan 2002 22:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288765AbSAIDxQ>; Tue, 8 Jan 2002 22:53:16 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:50696 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S288478AbSAIDxD>; Tue, 8 Jan 2002 22:53:03 -0500
Date: Wed, 9 Jan 2002 14:52:56 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: CaT <cat@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `local symbols in discarded section
 .text.exit
In-Reply-To: <20020109010122.GC822@zip.com.au>
Message-ID: <Pine.LNX.4.31.0201091445570.9931-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, CaT wrote:

> I have modules and hotplug turned on (but nothing turned on in the
> hotplug suboptions) but I get this error anyway:
>
>         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
> /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> net/network.o(.text.lock+0x1730): undefined reference to `local symbols
> in discarded section .text.exit'
> make: *** [vmlinux] Error 1
>

If you have CONFIG_IP_NF_NAT_SNMP_BASIC=y, see:

http://groups.google.com/groups?selm=18061.1009501031%40ocs3.intra.ocs.com.au



- James
-- 
James Morris
<jmorris@intercode.com.au>



