Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUJSO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUJSO5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbUJSO5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:57:12 -0400
Received: from lucidpixels.com ([66.45.37.187]:32901 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S269435AbUJSO5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:57:03 -0400
Date: Tue, 19 Oct 2004 10:57:02 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Jesse Stockall <stockall@magma.ca>
cc: nvidia@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 breaks NVidia module, cannot start X.
In-Reply-To: <1098197596.5339.10.camel@homer.blizzard.org>
Message-ID: <Pine.LNX.4.61.0410191056030.10356@p500>
References: <Pine.LNX.4.61.0410191040270.8554@p500> <1098197596.5339.10.camel@homer.blizzard.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, it is now working!

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   493 root      15   0  287m  27m 272m S  9.0  1.3   0:09.83 X

$ uname -a
Linux box 2.6.9 #2 SMP Tue Oct 19 10:51:55 EDT 2004 i686 unknown unknown 
GNU/Linux


On Tue, 19 Oct 2004, Jesse Stockall wrote:

> On Tue, 2004-10-19 at 10:42, Justin Piszcz wrote:
>> # dmesg
>> nvidia: module license 'NVIDIA' taints kernel.
>> nvidia: Unknown symbol __VMALLOC_RESERVE
>> nvidia: Unknown symbol __VMALLOC_RESERVE
>>
>
> Try
>
> http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck1/patches/nvidia_compat.diff
>
> Jesse
>
>
