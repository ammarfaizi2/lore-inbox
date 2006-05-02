Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWEBAOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWEBAOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWEBAOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:14:09 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:44207 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751263AbWEBAOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:14:08 -0400
In-Reply-To: <aday7xlqqaf.fsf@cisco.com>
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com> <ada7j55vayj.fsf@cisco.com> <4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org> <adapsixs9rg.fsf@cisco.com> <114102B4-FBCB-4A5A-B986-80D4A730DD91@kernel.crashing.org> <aday7xlqqaf.fsf@cisco.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C5B86DAC-A8B2-4EF1-9C61-89125707DF92@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [openib-general] Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
Date: Tue, 2 May 2006 02:13:59 +0200
To: Roland Dreier <rdreier@cisco.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Segher> And it builds just fine -- what is the problem you're
>     Segher> thinking of?
>
> Well, the ipath driver depends on PCI_MSI, and PCI_MSI depends on
> (X86_LOCAL_APIC && X86_IO_APIC) || IA64

Oh, that.  Right.  It's about time I get my whole MSI patch set into
shape for submission here, yes.

> So how do you enable the driver?

In a very hackish way right now :-(

> And what powerpc platform can you use the device on?

The latest PowerMac's have hardware support for MSI, to name just
one platform.


Segher

