Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTAUXlL>; Tue, 21 Jan 2003 18:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTAUXlK>; Tue, 21 Jan 2003 18:41:10 -0500
Received: from holomorphy.com ([66.224.33.161]:13968 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267345AbTAUXlK>;
	Tue, 21 Jan 2003 18:41:10 -0500
Date: Tue, 21 Jan 2003 15:50:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone have a 16-bit x86 early_printk?
Message-ID: <20030121235013.GP780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030114113036.GG940@holomorphy.com> <1043116327.13142.11.camel@dhcp22.swansea.linux.org.uk> <20030121061055.GN780@holomorphy.com> <3E2D83D8.5070108@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2D83D8.5070108@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It actually turned out to be a bug in the early_printk I was using that
>> killed it on the first call to it, but the availability of this will
>> certainly broaden the scope of what I can feasibly debug.

On Tue, Jan 21, 2003 at 09:31:04AM -0800, Dave Hansen wrote:
> Are you using the one that calls console_setup(), then initializes the
> serial driver directly?  I was seeing some strange behavior with that
> yesterday, but I assumed that it was my patch crashing in early boot.
> What was the bug?

I don't think that was the one, no. I didn't bother debugging it and just
hand-coded the bitbanging directly in asm.


-- wli
