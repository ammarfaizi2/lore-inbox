Return-Path: <linux-kernel-owner+w=401wt.eu-S1751246AbXAILVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbXAILVF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXAILVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:21:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33925 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbXAILVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:21:04 -0500
Message-ID: <45A37A9B.2000505@garzik.org>
Date: Tue, 09 Jan 2007 06:20:59 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Maarten Vanraes <maarten.vanraes@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AHCI IDENTIFY problem only on x86_64
References: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>	 <45A371E3.9090103@garzik.org>	 <6f61137b0701090247l6077cbb8k91eec388779c33cd@mail.gmail.com>	 <45A37497.6020505@garzik.org> <6f61137b0701090311gb82f392l626973b11d8911e9@mail.gmail.com>
In-Reply-To: <6f61137b0701090311gb82f392l626973b11d8911e9@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maarten Vanraes wrote:
> so, the problem is already solved then? at what minimal kernel version
> was that problem solved?
> 
> i didn't see it in the changelogs, but i may not have seen them all...
> 
> If i know the version, i can submit the info to them...

The SATA drivers have seen /hundreds/ of changes since your kernel was 
released, and the problem you describe is a symptom of /multiple/ 
problems that were fixed in the following kernels.

It's unfortunately your task, and the task of the 2.6.16.* maintainer, 
to track this down further if you care.  Most developers concentrate on 
the current kernel, otherwise we wind up fixing the same bugs over and 
over again.

That's what distros pay people to do, care about older kernels...

	Jeff



