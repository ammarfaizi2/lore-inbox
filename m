Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTBBUvE>; Sun, 2 Feb 2003 15:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTBBUvE>; Sun, 2 Feb 2003 15:51:04 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:25043 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S265567AbTBBUvD>;
	Sun, 2 Feb 2003 15:51:03 -0500
References: <courier.3E3D59B9.00006CAD@softhome.net>
            <20030202185836.B32007@flint.arm.linux.org.uk>
In-Reply-To: <20030202185836.B32007@flint.arm.linux.org.uk> 
From: b_adlakha@softhome.net
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what all has changed in ppp?
Date: Sun, 02 Feb 2003 14:00:33 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.82.196]
Message-ID: <courier.3E3D86F1.00001BF0@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes: 

> On Sun, Feb 02, 2003 at 10:47:37AM -0700, b_adlakha@softhome.net wrote:
>> sorry, I haven't been keeping up with the changes in 2.5, but I can't get 
>> pppd to work with 2.5.59, it dies with error code 1 while it works alright 
>> with 2.4.20... 
> 
> You need to look in the system log files (typically /var/log/messages) to
> see why pppd isn't happy.

Oh yes, sorry I forgot, module tty_ldisk3 cannot be found, so ppp dies with 
exit status 1...
I didn't think ppp needs anything other than ppp_generic, the serial driver 
for ppp and the compression modules...
What is tty_ldisk3? could you help me on this? 

Also, I haven't been able to solve the cpu problem...
and also, modprobe warns of unknown symbols in /etc/modules.devfs...although 
the 2.4 kernel works fine... 

