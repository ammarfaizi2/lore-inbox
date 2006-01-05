Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWAEKA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWAEKA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWAEKA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:00:59 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:9961 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751895AbWAEKA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:00:59 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Aniruddh Singh <aps@jobsahead.com>
Subject: Re: High load
Date: Thu, 5 Jan 2006 21:00:44 +1100
User-Agent: KMail/1.9
Cc: linux <linux-kernel@vger.kernel.org>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
In-Reply-To: <1136454597.6016.7.camel@aps.monsterindia.noida>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601052100.45107.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 20:49, Aniruddh Singh wrote:
> HI all,
>
> I have one compaq server with 4 Intel(R) Xeon cpu's (3.1GHZ), 4GB RAM.
> OS:- Fedora Core 2
> Kernel:- 2.6.14
>
> when i compile a new kernel, during th compilation process load goes
> very high (10 and little above). i can not understand why does this
> happen, while if i compile the same kernel on my P4 machine with 1GB ram
> and 3GHZ, it remains under 3.
>
> can somebody tell me what is wrong?
> -

Sounds suspiciously like DMA is not working on your drives. Check your dmesg 
logs and what hdparm returns.

Con
