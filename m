Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWFZOs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWFZOs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWFZOsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:48:25 -0400
Received: from dvhart.com ([64.146.134.43]:45732 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030292AbWFZOsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:48:24 -0400
Message-ID: <449FF3A2.8010907@mbligh.org>
Date: Mon, 26 Jun 2006 07:48:02 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>
In-Reply-To: <449D5D36.3040102@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Panic on PPC64. I'm guessing it's the same as the i386 panics I sent
> you yesterday, just more cryptic ;-) But for the record ...
> 
> http://test.kernel.org/abat/37737/debug/console.log
> 
> cpu 0x2: Vector: 300 (Data Access) at [c0000000f99f78c0]
>     pc: c0000000000c6a34: .s_show+0x178/0x364
>     lr: c0000000000c696c: .s_show+0xb0/0x364
>     sp: c0000000f99f7b40
>    msr: 8000000000001032
>    dar: fd528000
>  dsisr: 40000000
>   current = 0xc0000000f23e0000
>   paca    = 0xc00000000046e300
>     pid   = 17653, comm = cp
> enter ? for help
> 

Eeek, this is definitely an intermittent thing. I was trawling older
results, and it shows up (on PPC only) in 2.6.17-git10, so it's not
just an -mm thing ;-(


M.
