Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbSLLVlq>; Thu, 12 Dec 2002 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbSLLVlq>; Thu, 12 Dec 2002 16:41:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8970 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267495AbSLLVlp>; Thu, 12 Dec 2002 16:41:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: NFS mounted rootfs possible via PCMCIA NIC ?
Date: 12 Dec 2002 13:49:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <atb092$6do$1@cesium.transmeta.com>
References: <200212112253.57325.andreas.schaufler@gmx.de> <1039648320.18467.49.camel@irongate.swansea.linux.org.uk> <200212121829.46465.andreas.schaufler@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200212121829.46465.andreas.schaufler@gmx.de>
By author:    Andreas Schaufler <andreas.schaufler@gmx.de>
In newsgroup: linux.dev.kernel
>
> ...
> > PCMCIA relies in part on user space. You can do this, it involves
> > building a large initrd with a dhcp client on it that sets up pcmcia,
> > then nfs mounts stuff, then pivot_root()'s into it. Its not exactly
> > trivial
> 
> Thanks for your reply. I get the basic idea from what you say. But what do you 
> mean by pivot_root()'ing into it ?!?
> 

pivot_root() is a system call which flips the root directory around.
See Documentation/initrd.txt.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
