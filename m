Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSGHUyn>; Mon, 8 Jul 2002 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSGHUym>; Mon, 8 Jul 2002 16:54:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63875 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317140AbSGHUyl>; Mon, 8 Jul 2002 16:54:41 -0400
Date: Mon, 8 Jul 2002 17:00:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: list of compiled in support
In-Reply-To: <630DA58AD01AD311B13A00C00D00E9BC05D2020A@CSREESSERVER>
Message-ID: <Pine.LNX.3.95.1020708165520.21754A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

