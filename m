Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279822AbRLEPZL>; Wed, 5 Dec 2001 10:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278665AbRLEPYw>; Wed, 5 Dec 2001 10:24:52 -0500
Received: from [213.225.90.118] ([213.225.90.118]:26381 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S279822AbRLEPYp>;
	Wed, 5 Dec 2001 10:24:45 -0500
Date: Wed, 5 Dec 2001 15:23:08 +0100 (CET)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@lexx.infeline.org
To: David Woodhouse <dwmw2@infradead.org>
cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove bogus #include <asm/segment.h>
In-Reply-To: <8642.1007564208@redhat.com>
Message-ID: <Pine.LNX.4.40L0.0112051509500.3642-100000@lexx.infeline.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, David Woodhouse wrote:

> The following patch, made against 2.5.1-pre5 but tested in 2.4.16, removes
> the bogus includes from all generic code which doesn't need it (i.e. all
> generic code).

You're leaving a few empty #else statements in there. And it looks like
you cut a line from a comment in one place.

Ketil - not a kernel hacker

