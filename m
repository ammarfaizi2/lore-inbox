Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWAQBcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWAQBcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 20:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAQBcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 20:32:16 -0500
Received: from lucidpixels.com ([66.45.37.187]:38342 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751315AbWAQBcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 20:32:15 -0500
Date: Mon, 16 Jan 2006 20:32:14 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Phil Oester <kernel@linuxace.com>
cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <20060117012319.GA22161@linuxace.com>
Message-ID: <Pine.LNX.4.64.0601162031220.2501@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34> <20060117012319.GA22161@linuxace.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, some people mentioned tuning, I used 8192 as the w/r size it then 
took 15 seconds, with 65535 it took 28 seconds.

I wonder how much faster NFS over TCP would be, or if NFS in the kernel is 
the problem itself?

Will try later thanks.

FTP seems to be the winner for now:

<--- 226 8.927 seconds (measured here), 78.31 Mbytes per second
733045488 bytes transferred in 9 seconds (77.08M/s)


On Mon, 16 Jan 2006, Phil Oester wrote:

> On Mon, Jan 16, 2006 at 08:07:02PM -0500, Justin Piszcz wrote:
>> I suppose I should try NFS with TCP, yes?
>
> Precisely.
>
> Phil
>
