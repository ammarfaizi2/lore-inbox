Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262752AbREONcx>; Tue, 15 May 2001 09:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262754AbREONcn>; Tue, 15 May 2001 09:32:43 -0400
Received: from [195.6.125.97] ([195.6.125.97]:37381 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S262752AbREONca>;
	Tue, 15 May 2001 09:32:30 -0400
Date: Tue, 15 May 2001 15:30:39 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: get data to user space from kernel
Message-Id: <20010515153039.68bbd9e0.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a network driver that get specific informations from device
but I can't envisage the size of the informations. So I do a kmalloc
call when data come.

But my problem seems to come from the kmalloc because when I try to
send data to user space via an ioctl call I get a segmentation fault.

One solution would be to pass fixed size beetween the both but it 
isn't the cleaner.

I've heard about copy_to_user method , is it the best way ?
Is there a way to create a struct in user space dynamicaly from kernel
space ?

thanks for any help ...

sebastien person
