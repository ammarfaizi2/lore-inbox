Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTCCPjq>; Mon, 3 Mar 2003 10:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTCCPjp>; Mon, 3 Mar 2003 10:39:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48027
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266292AbTCCPjp>; Mon, 3 Mar 2003 10:39:45 -0500
Subject: Re: Dmesg: Use a PAE enabled kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Walrond <andrew@walrond.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E63736F.6090000@walrond.org>
References: <3E63736F.6090000@walrond.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046710454.6509.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 16:54:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 15:23, Andrew Walrond wrote:
> During bootup I see
> 
>    Warning only 4GB will be used.
>    Use a PAE enabled kernel.
> 
> But I only have 4Gb installed, so is this message wrong?

Yes. Its confusing 4Gb of memory with 4Gb of address space.
4Gb of RAM comes out as
[RAM][ISA][RAM....][PCI] {4GbLimit} [RAM]


