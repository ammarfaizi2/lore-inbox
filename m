Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWEEOZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWEEOZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWEEOZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:25:50 -0400
Received: from bay105-f6.bay105.hotmail.com ([65.54.224.16]:49359 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751127AbWEEOZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:25:50 -0400
Message-ID: <BAY105-F6D90B6DEFD812FADBCC25E9B50@phx.gbl>
X-Originating-IP: [208.48.46.1]
X-Originating-Email: [rwm_rietveld@hotmail.com]
In-Reply-To: <445B479C.1060401@argo.co.il>
From: "Roy Rietveld" <rwm_rietveld@hotmail.com>
To: avi@argo.co.il
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
Date: Fri, 05 May 2006 14:25:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 05 May 2006 14:25:47.0537 (UTC) FILETIME=[CD475810:01C6704F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks now i know, the stack is slow 40MBit on loopback.


>From: Avi Kivity <avi@argo.co.il>
>To: Roy Rietveld <rwm_rietveld@hotmail.com>
>CC: P@draigBrady.com, linux-kernel@vger.kernel.org
>Subject: Re: TCP/IP send, sendfile, RAW
>Date: Fri, 05 May 2006 15:39:56 +0300
>
>Roy Rietveld wrote:
>>the platform is a netsilicon NS9360 witch include an 100MBit ethernet 
>>device.
>>The driver came with the software(LxNETES) for the development board.
>>CPU load is 100% when running sender program.
>>
>>cat /proc/interrupts; sleep 10; cat /proc/interrupts doen't work anymore 
>>because cpu is to busy.
>>
>>Does sendto give other processes time when the hardware is transmitting 
>>data?
>>Is this bad hardware or is the cost of sendto that high.
>
>Try sending UDP over loopback and see.
>
>--
>Do not meddle in the internals of kernels, for they are subtle and quick to 
>panic.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


