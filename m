Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVAGDAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVAGDAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVAGDAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:00:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57279 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261203AbVAGC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:59:48 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, ast@domdv.de, rlrevell@joe-job.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       joq@io.com
In-Reply-To: <20050107011309.GB2995@waste.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>
	 <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	 <1104898693.24187.162.camel@localhost.localdomain>
	 <20050104215010.7f32590e.akpm@osdl.org>
	 <20050105120601.GA8730@mail.13thfloor.at> <20050107011309.GB2995@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105062723.17166.319.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 01:55:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 01:13, Matt Mackall wrote:
> You can't fix them without changing the semantics for existing users
> in ways they didn't expect. It could be done with a new personality flag,
> but..

I disagree. At the most trivial you could just add another 32bits of
sticky capability that are never touched by setuid/non-setuidness and
represent additional "user" (or more rightly session) abilities to do
limited overrides

