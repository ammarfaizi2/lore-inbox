Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311416AbSCSQqH>; Tue, 19 Mar 2002 11:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311415AbSCSQp5>; Tue, 19 Mar 2002 11:45:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:18948 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311416AbSCSQpo>; Tue, 19 Mar 2002 11:45:44 -0500
Message-ID: <3C976AE4.5070309@evision-ventures.com>
Date: Tue, 19 Mar 2002 17:44:20 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <Pine.LNX.4.44.0203191716170.24700-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> HI,
> 
> also with 2.5.7, as with 2.5.6, I have problems at boot.
> I get the usual oops while initialising IDE.
> 
> my ide controller is:
> 
> 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> [Master])
>         Subsystem: Intel Corporation 82801AA IDE
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at 2460 [size=16]
> 
> unfortunatelly, I do not have even the time to write down oops message,
> but eip is c0135068, but then I do not find a similar entry in system.map
> 
> any hint

The entries found there are just the starting points of functions.
You can therefore look up the function where th oops happens
by looking at the nearest lower number in System.map.

> my rootfs in reiserFS, but i do not even reach the mount ...

That should not matter.

