Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269745AbUJHKRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbUJHKRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUJHKRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:17:50 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:27311 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269717AbUJHKRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:17:42 -0400
Message-ID: <4166693D.1080207@kolivas.org>
Date: Fri, 08 Oct 2004 20:17:33 +1000
From: Con Kolivas <lkml@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3: firefox SIGSEGV
References: <D1F168BB-1911-11D9-B4FB-000D9352858E@linuxmail.org>
In-Reply-To: <D1F168BB-1911-11D9-B4FB-000D9352858E@linuxmail.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> I'm having trouble launching firefox-0.10.1-1.0PR1.8 from Fedora Core 
> Rawhide under 2.6.9-rc3-mm3 as it always segfaults. However, I can under 
> 2.6.9-rc3-mm2. Don't know what's really going on, so I've attached the 
> output of "strace".
> 
> Any ideas?

Known issue.

This fixes it:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109714329614794&w=2

Cheers,
Con
