Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310783AbSCMQkd>; Wed, 13 Mar 2002 11:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310790AbSCMQkY>; Wed, 13 Mar 2002 11:40:24 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:47262 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S310783AbSCMQkL>; Wed, 13 Mar 2002 11:40:11 -0500
Date: Wed, 13 Mar 2002 08:40:26 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrea Arcangeli <andrea@suse.de>, Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: Re: [PATCH] Support for assymmetric SMP
Message-ID: <467625960.1016008825@[10.10.2.3]>
In-Reply-To: <E16lBRo-0006jU-00@the-village.bc.nu>
In-Reply-To: <E16lBRo-0006jU-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Actually I know of at least one dual P4 Xeon board where I 
>> haven't seen anything except IPI go to the second cpu.
> 
> Expect that to occur. The random distribution stuff doesn't seem to be a
> feature of all pentium IV systems. Ie this bug does want fixing

Dave Olien published a patch which will make this issue much
better for P4 - setting the TPR so we route interrupts according 
to how important the processors current work is. Should alleviate
the "dump everything on one CPU" P4ness.

Would still be nice to fix this though.

M.

