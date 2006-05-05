Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWEEMkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWEEMkH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 08:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWEEMkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 08:40:06 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:27663 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751540AbWEEMkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 08:40:05 -0400
Message-ID: <445B479C.1060401@argo.co.il>
Date: Fri, 05 May 2006 15:39:56 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roy Rietveld <rwm_rietveld@hotmail.com>
CC: P@draigBrady.com, linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
References: <BAY105-F14065377CA78E7380B26DCE9B50@phx.gbl>
In-Reply-To: <BAY105-F14065377CA78E7380B26DCE9B50@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2006 12:40:02.0792 (UTC) FILETIME=[07841680:01C67041]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Rietveld wrote:
> the platform is a netsilicon NS9360 witch include an 100MBit ethernet 
> device.
> The driver came with the software(LxNETES) for the development board.
> CPU load is 100% when running sender program.
>
> cat /proc/interrupts; sleep 10; cat /proc/interrupts doen't work 
> anymore because cpu is to busy.
>
> Does sendto give other processes time when the hardware is 
> transmitting data?
> Is this bad hardware or is the cost of sendto that high.

Try sending UDP over loopback and see.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

