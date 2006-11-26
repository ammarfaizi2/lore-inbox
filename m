Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753329AbWKZWxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbWKZWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbWKZWxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:53:25 -0500
Received: from mx0.towertech.it ([213.215.222.73]:16852 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1753329AbWKZWxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:53:24 -0500
Date: Sun, 26 Nov 2006 23:53:17 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, <akpm@osdl.org>,
       <linuxppc-dev@ozlabs.org>, <lethal@linux-sh.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <ralf@linux-mips.org>, "'Andi Kleen'" <ak@muc.de>, <paulus@samba.org>,
       <rmk@arm.linux.org.uk>, <davem@davemloft.net>, <kkojima@rr.iij4u.or.jp>
Subject: Re: NTP time sync
Message-ID: <20061126235317.5d40d22c@inspiron>
In-Reply-To: <00b301c711a3$07cf3530$020120ac@Jocke>
References: <20061126202148.190d5b4b@inspiron>
	<00b301c711a3$07cf3530$020120ac@Jocke>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006 22:37:10 +0100
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> >  the concept of static numbers is quite old...
> 
> Yes it is old, but is the old way unsupported now? I have an embedded target
> which is using the old static /dev directory, do I need to make
> it udev aware to use newer features like the rtc subsystem?

 That can be a good option. You can also do
 a symlink to /dev/rtc0 in your boot scripts or simply
 upgrade your hwclock to a version that accepts
 the device as a parameter.

 The old /dev/rtc name is not supported on the new rtc subsystem.

 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

