Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbUK0AK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbUK0AK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUK0AGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:06:54 -0500
Received: from web50506.mail.yahoo.com ([206.190.38.82]:64938 "HELO
	web50506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263120AbUK0AES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:04:18 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=pnjKiVrg+JOP+3Kn+aOzS5l0Q5ewB+40K54i7TlMwLmq9j6o91luRDYke+egzc/lKmpZXVQE+3fCIpPVnavCIuWtnbRI0lZbJAo9c6JvTZvOM98w4QoN1SlGok9L0O+kk5LY2QT81kkeisFjk/Wtyo5+M5pEiSzPN6ZBBMYOAPQ=  ;
Message-ID: <20041127000414.74351.qmail@web50506.mail.yahoo.com>
Date: Fri, 26 Nov 2004 16:04:14 -0800 (PST)
From: lan mu <mu8lan2003@yahoo.com>
Subject: mmap and multiple memory chucks allocated by kmalloc()
To: linux-kernel@vger.kernel.org
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111ED5FF@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi experts,

I have almost 620000 bytes data store in Kernal space
and would like to pass to user space via mmap.

Can I use the kmalloc to allocate 5 memory chucks
(4096*30) and then use remap_page_range() to map those
5 chucks one by one? it not seems to work. Anyone can
tell me if it's feasible? or I have to use vmalloc?

Now I only can mmaped the first chuck buffer and make
it work.

Since I'm not in the user group list, please send
directly email to me.

Thanks your help in advance!

-Lan


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
