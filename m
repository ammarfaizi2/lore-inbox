Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279998AbRKDOLN>; Sun, 4 Nov 2001 09:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279999AbRKDOLE>; Sun, 4 Nov 2001 09:11:04 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:61105 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279998AbRKDOKr>; Sun, 4 Nov 2001 09:10:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Sun, 4 Nov 2001 15:13:37 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de>
In-Reply-To: <20011104143631.B1162@pelks01.extern.uni-tuebingen.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160Nyq-2ACgt6C@fmrl07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 14:36, Daniel Kobras wrote:
> Certainly you can further fields without breaking (well-written) apps.
> That's what the first line in /proc/partitions is for. When adding a new
> column, you also give it a new tag in the header. Ask RedHat how many apps
> broke when they started patching sard into their kernels.

The format won't help you when you have strings with whitespace or if you 
want to export a list for each partition. 

> Adding new fields is even easier with /proc/stat-style key:value pairs.
> Both styles are human- as well as machine readable. Problems only arise
> when someone changes the semantics of a certain field without changing the
> tag. But luckily these kinds of changes never happen in a stable kernel
> series...

I don't think that this format is very user friendly, and it has the same 
limitations as /proc/partitions. 

The problem is not that it is impossible to invent a new format for every 
file. The problem is that you need a different format for each file.

bye...
