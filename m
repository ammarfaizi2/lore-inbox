Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262677AbTCPPDW>; Sun, 16 Mar 2003 10:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbTCPPDW>; Sun, 16 Mar 2003 10:03:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9131 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262677AbTCPPDV>; Sun, 16 Mar 2003 10:03:21 -0500
Date: Sun, 16 Mar 2003 07:10:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <57410000.1047827453@[10.10.2.4]>
In-Reply-To: <20030316082911.GA777@gnuppy.monkey.org>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]> <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]> <20030316044524.GA6757@gnuppy.monkey.org> <12150000.1047793549@[10.10.2.4]> <20030316063151.GA7114@gnuppy.monkey.org> <19840000.1047797300@[10.10.2.4]> <20030316065650.GA8164@gnuppy.monkey.org> <20280000.1047798483@[10.10.2.4]> <20030316082911.GA777@gnuppy.monkey.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What happens if you turn this bit off ?
>> CONFIG_DEBUG_SLAB=y
> 
> Well, uh, now it just flat out hangs right after it decompresses
> the kernel image. I've got an "Intel i815EEA" here, pure UP. Hmmm.

Hmmm ... does just -bk3 do the same thing with the same config file?
I guess you could try the early_printk stuff, but ISTR either VGA
or serial was broken ... but I forget which ;-(. I'll try to fix
that up later.

M.

