Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbTE1L11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbTE1L11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:27:27 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:8360 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264687AbTE1L10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:27:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 21:41:43 +1000
User-Agent: KMail/1.5.1
Cc: axboe@suse.de, matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com>
In-Reply-To: <20030528042700.47372139.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305282141.43829.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 21:27, Andrew Morton wrote:
> Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
> > Does the attached one make sense?
>
> Nope.
>
> Guys, you're the ones who can reproduce this.  Please spend more time
> working out which chunk (or combination thereof) actually fixes the
> problem.  If indeed any of them do.
>
> I'm suspecting that Con's fingers slipped.

I've been known to be email trigger happy in the past but a serious thrashing 
with just this one change made massive improvements. 

However - 
One test case does not a fix give.

Others please test this. It's extremely important.

If you're interested the best test for me is:
dd if=/dev/zero of=dump bs=4096 count=512000

Con
