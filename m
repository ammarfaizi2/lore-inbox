Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRIYWAh>; Tue, 25 Sep 2001 18:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIYWA1>; Tue, 25 Sep 2001 18:00:27 -0400
Received: from jcb.yi.org ([80.65.224.59]:13696 "HELO athena")
	by vger.kernel.org with SMTP id <S271848AbRIYWAP>;
	Tue, 25 Sep 2001 18:00:15 -0400
Date: Wed, 26 Sep 2001 00:00:23 +0200
From: jc <jcb@jcb.yi.org>
To: linux-kernel@vger.kernel.org
Subject: apm suspend broken in 2.4.10
Message-ID: <20010926000023.A2291@athena>
Mail-Followup-To: jc <jcb@jcb.yi.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it worked fine with 2.4.9

now with 2.4.10 :

strace apm -s 

...
open("/dev/apm_bios", O_RDWR)           = 3
time([1001455050])                      = 1001455050
sync()                                  = 0
ioctl(3, AGPIOC_RELEASE, 0)             = -1 EAGAIN (Resource temporarily unavailable)
...


