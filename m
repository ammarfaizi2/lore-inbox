Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSGIM6Z>; Tue, 9 Jul 2002 08:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSGIM6Y>; Tue, 9 Jul 2002 08:58:24 -0400
Received: from [199.128.236.1] ([199.128.236.1]:37645 "EHLO
	intranet.reeusda.gov") by vger.kernel.org with ESMTP
	id <S315202AbSGIM6W>; Tue, 9 Jul 2002 08:58:22 -0400
Message-ID: <630DA58AD01AD311B13A00C00D00E9BC05D20210@CSREESSERVER>
From: "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
       "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: list of compiled in support
Date: Tue, 9 Jul 2002 09:01:37 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

great, thanks

Michael Martinez
System Administrator (Contractor)
Information Systems and Technology Management
CSREES - United States Department of Agriculture
(202) 720-6223


-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Monday, July 08, 2002 5:01 PM
To: Martinez, Michael - CSREES/ISTM
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: list of compiled in support


On Mon, 8 Jul 2002, Martinez, Michael - CSREES/ISTM wrote:

> How does one tell if a kernel has compiled in support for ipx?
> 
> Michael Martinez
> System Administrator (Contractor)
> Information Systems and Technology Management
> CSREES - United States Department of Agriculture
> (202) 720-6223
> 

You can tell if it supports ipx, but you can't tell if it supports
it because you loaded a module or because it was compiled in.


`ls /proc/net/ipx*`  will show.......

           ipx ipx_interface ipx_route

... if you've got ipx enabled (somehow).

To find if it's enabled by a module, then you can then do:

`lsmod | grep ipx` if you found it was enabled.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.
