Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWG3Sax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWG3Sax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWG3Sax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:30:53 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:1299 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932416AbWG3Saw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:30:52 -0400
Message-ID: <44CCFAD3.2050607@argo.co.il>
Date: Sun, 30 Jul 2006 21:30:43 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <200607302015.33684.ak@suse.de>
In-Reply-To: <200607302015.33684.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2006 18:30:50.0919 (UTC) FILETIME=[48B3E370:01C6B406]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>
> >
> > Cannot work on x86-64, even disregarding fp exceptions, because
> > kernel_fpu_begin() doesn't save the sse state which is used by fp math.
> >
> > No?
>
> It does - FXSAVE saves everything.
>

I see.  Thanks for clearing it up.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

