Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUEUWpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUEUWpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUEUWnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:43:41 -0400
Received: from web12303.mail.yahoo.com ([216.136.173.101]:35688 "HELO
	web12303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264836AbUEUWgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:36:06 -0400
Message-ID: <20040521194224.63535.qmail@web12303.mail.yahoo.com>
Date: Fri, 21 May 2004 12:42:24 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: x86_64 and ioctls from 32 bit userland
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, a question about x86_64 and ioctls coming in from 32-bit
userland.

I found this document describing 32-bit ioctls on 64 bit archs,
http://shorterlink.com/?47B2OV
but, it is from July of 2002, so I'm not sure it's up to date.
Should I look somewhere else?

Also, if my userland process passes in an ioctl data structure
and that data structure in turn contains ontains a 32 bit pointer
to another data buffer within that process' address space
the kernel needs to copy in/oot, how can that be handled?
Can it be handled?

Thanks,

-- steve



	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
