Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTAURXE>; Tue, 21 Jan 2003 12:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTAURXE>; Tue, 21 Jan 2003 12:23:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:16070 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267135AbTAURXD>; Tue, 21 Jan 2003 12:23:03 -0500
Message-ID: <3E2D83D8.5070108@us.ibm.com>
Date: Tue, 21 Jan 2003 09:31:04 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone have a 16-bit x86 early_printk?
References: <20030114113036.GG940@holomorphy.com> <1043116327.13142.11.camel@dhcp22.swansea.linux.org.uk> <20030121061055.GN780@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> It actually turned out to be a bug in the early_printk I was using that
> killed it on the first call to it, but the availability of this will
> certainly broaden the scope of what I can feasibly debug.

Are you using the one that calls console_setup(), then initializes the
serial driver directly?  I was seeing some strange behavior with that
yesterday, but I assumed that it was my patch crashing in early boot.
What was the bug?

-- 
Dave Hansen
haveblue@us.ibm.com

