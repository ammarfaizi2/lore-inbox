Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWAZKH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWAZKH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAZKH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:07:27 -0500
Received: from quechua.inka.de ([193.197.184.2]:12673 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932272AbWAZKHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:07:25 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Red zones
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <43D85DF4.9020703@cosmosbay.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F242F-000160-00@calista.inka.de>
Date: Thu, 26 Jan 2006 11:07:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
> On x86_64, available virtual space is huge, so having different red zones can 
> spot the fault more easily : If the target of the fault is in the PER_CPU 
> redzone given range, we can instantly knows there is still a per_cpu() user 
> accessing a non possible cpu area. As the red zone is not mapped at all, no 
> page table is setup.

Ok, however you can also tell from the stack trace who accessed the red zone, right?

Gruss
Bernd
