Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUDEK2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUDEK2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:28:20 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:29861 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S261168AbUDEK0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:26:48 -0400
Message-ID: <40713681.6060308@rgadsdon2.giointernet.co.uk>
Date: Mon, 05 Apr 2004 11:35:45 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
Reply-To: rgadsdon2@netscape.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 - panic when intensive disk access on 120GB firewire disk
References: <40706EA2.7040900@rgadsdon2.giointernet.co.uk> <200404042356.21109.dtor_core@ameritech.net>
In-Reply-To: <200404042356.21109.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the problem on my system.  All I get is a couple of
'ieee1394: unsolicited response packet received - no tlabel match'
messages on the console.

Many thanks.

Robert Gadsdon.

Dmitry Torokhov wrote:
> On Sunday 04 April 2004 03:22 pm, Robert Gadsdon wrote:
> 
>>Kernel panic from 2.6.5 'final' when running slocate (updatedb) 
>>accessing 120GB firewire disk:
>>
>>Oops: 00002 [#1]
>>PREEMPT SMP
>>CPU: 0
>>EIP: 0060:[<f8a10a27>]  Not tainted
>>EFLAGS: 00010047 (2.6.5)
>>EIP is at hpsb_packet_sent+0x27/0x90 [ieee1394]
> 
> 
> Could you please try the patch below.
> 
> Thank you.

