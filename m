Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319664AbSIMOya>; Fri, 13 Sep 2002 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319668AbSIMOya>; Fri, 13 Sep 2002 10:54:30 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:13475 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319664AbSIMOy3> convert rfc822-to-8bit; Fri, 13 Sep 2002 10:54:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Parthiban M" <parthi_m@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Query on code space and data space !
Date: Fri, 13 Sep 2002 09:57:33 -0500
User-Agent: KMail/1.4.1
Cc: skotra@npd.hcltech.com, pamanick@npd.hcltech.com, nramamur@npd.hcltech.com
References: <F116NqfYwAYmY3pYNIT00019d42@hotmail.com>
In-Reply-To: <F116NqfYwAYmY3pYNIT00019d42@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130957.33528.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 09:23 am, Parthiban M wrote:
> Hi all :
>
> I'm using a linux box running RH7.3 (kernel 2.4.18-3).
> I've inserted one kernel module and I need information
> on how much code space and data space my module
> has consumed.
>
> Is there any way to know these statistics ? Doing a
> cat  /proc/<process ID>/status (or stat or statm)
> showed some information. But I'm not very clear.
>
> Any pointers in this regard are highly appreciated.

I think you really want /proc/modules....
though it doesn't distinguish between code space and
data space. At this level of the kernel there isn't any
difference.

> Thanks,
> Parthi.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
