Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132667AbRAXVlE>; Wed, 24 Jan 2001 16:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAXVky>; Wed, 24 Jan 2001 16:40:54 -0500
Received: from [64.64.109.142] ([64.64.109.142]:15634 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131882AbRAXVkm>; Wed, 24 Jan 2001 16:40:42 -0500
Message-ID: <3A6F4BB6.2C305145@didntduck.org>
Date: Wed, 24 Jan 2001 16:40:06 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jie Zhou <jiezhou@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about compiling the kernel
In-Reply-To: <OFF0DFC748.A1DDEA9C-ON852569DE.00754674@somers.hqregion.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jie Zhou wrote:
> 
> Hi, all,
> 
>  I got about 30 warning msgs like this during the process of "make
> bzImage",   is it a fatal problem or not?
>   "Warning: using '%eax' instead of '%ax' due to "l" suffix"

Nothing to worry about.

>  2. after 'make bzImage', if I don't have any module to install, then I
> don't need  to run either 'make modules' or 'make modules_install',
> is this correct?

Correct.

> 3. After I run the /sbin/lilo, it says the new kernel is added to the
> system. HOwever when I restart the system and go into the labeled kernel
> I choose, the system gets stucked after these two lines:
> Loading kernel.......................
> Uncompressing Linux...OK, booting the kernel.
> 
> Can you give me some advice on this. Thanks a lot for your kind reply..

Make certain you compiled the kernel for the proper CPU type (ie. don't
try to run a Pentium II kernel on a 486)

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
