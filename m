Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276802AbRJPWfa>; Tue, 16 Oct 2001 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276800AbRJPWfX>; Tue, 16 Oct 2001 18:35:23 -0400
Received: from air-1.osdl.org ([65.201.151.5]:24337 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S276745AbRJPWfQ>;
	Tue, 16 Oct 2001 18:35:16 -0400
Message-ID: <3BCCB51C.AF68D826@osdl.org>
Date: Tue, 16 Oct 2001 15:30:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cross Quad Port...?
In-Reply-To: <20011017002440.A29367@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> Hi.
> 
> When booting 2.4.12-ac2 on a dual PIII box, ServerWorks HE-SL, boot sequence
> stops at:
> 
> Cross Quad Port I/O vaddr 0xd0800000, len 00040000
> 
> What the h**l is that ??

Looks like a part of the IBM NUMAQ patch that should be
qualified by CONFIG_MULTIQUAD in arch/i386/kernel/smpboot.c.

~Randy
