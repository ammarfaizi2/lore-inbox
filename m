Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSHCXin>; Sat, 3 Aug 2002 19:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318022AbSHCXin>; Sat, 3 Aug 2002 19:38:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19446 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318020AbSHCXin>; Sat, 3 Aug 2002 19:38:43 -0400
Subject: Re: i386/kernel/pci-pc.c and tdfxfb.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Perry Gilfillan <perrye@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020803223614.13791.qmail@linuxmail.org>
References: <20020803223614.13791.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 02:00:13 +0100
Message-Id: <1028422813.3478.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 23:36, Perry Gilfillan wrote:
> The first is that in 2.4.18, arch/i386/kernel/pci-pc.c had pci_fixup for 
> the VIA VT82C597, 598, and 691 bridge chip sets.  
> 
> All referenc to the VT82C5xx chips seem to be remoed.

Actually I'm quite fond of my data so I'd prefer to leave them present.
2.4.19 knows about the onboard video corner case which 2.4.18 didnt.

The tdfx one I can't help on. Although if its X that is making a mess
probably there is an interaction between XFree86 and the kernel driver
that wants looking at by both parties to see what code is forgetting to 
restore what values

