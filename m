Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293008AbSCFVbG>; Wed, 6 Mar 2002 16:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293579AbSCFVa4>; Wed, 6 Mar 2002 16:30:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:34322 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293008AbSCFVar>;
	Wed, 6 Mar 2002 16:30:47 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: israel fdez <israel@seg.inf.cu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question?? 
In-Reply-To: Your message of "Wed, 06 Mar 2002 11:08:47 CDT."
             <3C863F0F.8000106@seg.inf.cu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Mar 2002 08:30:34 +1100
Message-ID: <19210.1015450234@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Mar 2002 11:08:47 -0500, 
israel fdez <israel@seg.inf.cu> wrote:
>Hi all, how can I get the full path of a module that is intended to be 
>insmod'ed into the kernel

# insmod -n loop
Using /lib/modules/2.4.17-xfs/kernel/drivers/block/loop.o
# modprobe -l '*loop*'
/lib/modules/2.4.17-xfs/kernel/drivers/block/loop.o

