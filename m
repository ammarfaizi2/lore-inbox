Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbRFMJ22>; Wed, 13 Jun 2001 05:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFMJ2R>; Wed, 13 Jun 2001 05:28:17 -0400
Received: from [195.6.125.97] ([195.6.125.97]:59908 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S262659AbRFMJ2N>;
	Wed, 13 Jun 2001 05:28:13 -0400
Date: Wed, 13 Jun 2001 11:28:16 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: memory allocation in a module serial network driver
Message-Id: <20010613112816.36d4bed5.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I try my module with a ping -f , it immediately freez, so I'd like to
know
what is the best flag for kmalloc when I send a packet and I have to copy
it 
in a new buffer (gfp_kernel | gfp_atomic ?)

Thanks
