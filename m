Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264613AbTE1IfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264615AbTE1IfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:35:17 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:13319 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264613AbTE1IfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:35:16 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 10:43:31 +0200
User-Agent: KMail/1.5.2
Cc: kernel@kolivas.org, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528005156.1fda5710.akpm@digeo.com> <20030528083028.GE845@suse.de>
In-Reply-To: <20030528083028.GE845@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305281032.58109.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 10:30, Jens Axboe wrote:

Hi Jens,

> The unplug() move could be the key, in theory we could end up having to
> unplug the queue again.
Hmm, afaik fix-pausing-2 patch does it similar, moving unplug_device() to the 
same place.

> Question to the ones seeing the stalls - does a sysrq-s make things go
> again?
no (at least not for me)

ciao, Marc


