Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbRGCJJz>; Tue, 3 Jul 2001 05:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265655AbRGCJJp>; Tue, 3 Jul 2001 05:09:45 -0400
Received: from [210.82.190.10] ([210.82.190.10]:28169 "HELO mx.linux.net.cn")
	by vger.kernel.org with SMTP id <S265647AbRGCJJn>;
	Tue, 3 Jul 2001 05:09:43 -0400
Date: Tue, 3 Jul 2001 15:48:00 +0800
From: Fang Han <dfbb@linux.net.cn>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
Message-ID: <20010703154759.A1409@dfbbb.cn.mvd>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3B415489.77425364@mandrakesoft.com> <20010703075050.B15457@dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010703075050.B15457@dev.sportingbet.com>; from sean@dev.sportingbet.com on Tue, Jul 03, 2001 at 07:50:50AM +0100
Organization: None
X-Attribution: dfbb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you build the drivers in, but forget to comment out the initrd line in
> /etc/lilo.conf, the machine panics because it tries to load the module for
> something that is already a builtin.
> 
The only way to solve it smothly need to modify the bootloader, When the 
bootloader like lilo or grub ( it is more powerful ) can read the module from the root partition directly. Your problem will be sloved.

BTW: Is there any system or tools can patch kernel in binary level, It means
     that user doesn't need download the whole kernel RPM or TGZ, It just need
     an patch to patch the current kernel's binary. I think it is useful for
     novice & end user.

Regards

dfbb

