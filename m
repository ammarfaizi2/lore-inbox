Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUKOWXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUKOWXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUKOWXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:23:49 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:15121 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261473AbUKOWXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:23:46 -0500
Message-ID: <41992C5C.9060201@techsource.com>
Date: Mon, 15 Nov 2004 17:23:24 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
References: <419914F9.7050509@techsource.com> <52is86lqur.fsf@topspin.com>
In-Reply-To: <52is86lqur.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Timothy> When I do 'lspci | grep -i audio', I get this:
>     Timothy> 0000:00:1f.5 Multimedia audio controller: Intel
>     Timothy> Corp. 82801BA/BAM AC'97 Audio (rev 04)
> 
> I would guess it should be supported by snd_intel8x0.  What are the
> exact device ID's (shown by lspci -n)?
> 
>  - R.
> 
> 

0000:00:00.0 Class 0600: 8086:2530 (rev 04)
0000:00:01.0 Class 0604: 8086:2532 (rev 04)
0000:00:1e.0 Class 0604: 8086:244e (rev 04)
0000:00:1f.0 Class 0601: 8086:2440 (rev 04)
0000:00:1f.1 Class 0101: 8086:244b (rev 04)
0000:00:1f.2 Class 0c03: 8086:2442 (rev 04)
0000:00:1f.3 Class 0c05: 8086:2443 (rev 04)
0000:00:1f.4 Class 0c03: 8086:2444 (rev 04)
0000:00:1f.5 Class 0401: 8086:2445 (rev 04)
0000:01:00.0 Class 0300: 1002:5961 (rev 01)
0000:01:00.1 Class 0380: 1002:5941 (rev 01)
0000:02:0c.0 Class 0200: 10b7:9200 (rev 78)


I don't get any sound out of the device when I WANT it, but I do 
periodically get the odd crackling and popping.


Thanks.
