Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTAUGCS>; Tue, 21 Jan 2003 01:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAUGCP>; Tue, 21 Jan 2003 01:02:15 -0500
Received: from holomorphy.com ([66.224.33.161]:57228 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264715AbTAUGB6>;
	Tue, 21 Jan 2003 01:01:58 -0500
Date: Mon, 20 Jan 2003 22:10:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone have a 16-bit x86 early_printk?
Message-ID: <20030121061055.GN780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030114113036.GG940@holomorphy.com> <1043116327.13142.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043116327.13142.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 11:30, William Lee Irwin III wrote:
>> I'm trying to get a box to boot and it appears to drop dead before
>> start_kernel(). Would anyone happen to have an early_printk() analogue
>> for 16-bit x86 code?

On Tue, Jan 21, 2003 at 02:32:07AM +0000, Alan wrote:
> Linux 8086 has a complete mini-linux for it, let alone printk. A bcc
> compileable printk is included

It actually turned out to be a bug in the early_printk I was using that
killed it on the first call to it, but the availability of this will
certainly broaden the scope of what I can feasibly debug.


Thanks,
Bill
