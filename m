Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTBFXYW>; Thu, 6 Feb 2003 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTBFXYV>; Thu, 6 Feb 2003 18:24:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:28113 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267534AbTBFXYV>; Thu, 6 Feb 2003 18:24:21 -0500
Date: Thu, 06 Feb 2003 15:33:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc -O2 vs gcc -Os performance
Message-ID: <283760000.1044574433@[10.10.2.4]>
In-Reply-To: <200302070017.18067.roger.larsson@skelleftea.mail.telia.com>
References: <336780000.1044313506@flay> <1044553691.10374.20.camel@irongate.swansea.linux.org.uk> <263740000.1044563891@[10.10.2.4]> <200302070017.18067.roger.larsson@skelleftea.mail.telia.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> gcc-3.2
>> 
>> 2901299 vmlinux.O2
>> 2667827 vmlinux.Os
>> 
> 
> In an earlier message, Martin J. Bligh wrote: 
>> 
>> 894822 Feb  5 23:50 /boot/vmlinuz-2.5.59-mjb3-Os
>> 906203 Feb  5 22:46 /boot/vmlinuz-2.5.59-mjb3.old
> 
> And if you compare both with  same/no  compression?

 980233 Feb  6 11:15 /boot/vmlinuz-2.5.59-mjb3
 914965 Feb  6 09:34 /boot/vmlinuz-2.5.59-mjb3.old

Those were probably the right files. (O2 and Os respectively)
I didn't look too  closely at the time. Looks like 2.95 produces
smaller files with O2 than 3.2 does with -Os. Bah.

/me cheers for gcc 2.95.4

M.

