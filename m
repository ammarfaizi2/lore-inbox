Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSETXFa>; Mon, 20 May 2002 19:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316432AbSETXF3>; Mon, 20 May 2002 19:05:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47610 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316430AbSETXF2>; Mon, 20 May 2002 19:05:28 -0400
Subject: Re: [PATCH] 2.4-ac: more scheduler updates (1/3)
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020520225858.GA1792@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 May 2002 16:03:37 -0700
Message-Id: <1021935821.958.1.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-20 at 15:58, J.A. Magallon wrote:

> On 2002.05.20 Robert Love wrote:
>
> >	- remove the RUN_CHILD_FIRST cruft from kernel/fork.c.
> >	  Pretty clear this works great; we do not need the ifdefs.
> 
> AFAIR, there was a problem with bash, I think.
> Is it corrected ?

I thought that was with the stock-scheduler when child-runs-first was
hacked into it?  As far as I know, it has always worked right in the
O(1) scheduler.  If not, it still is not a kernel issue and no one is
using these defines anyhow - they just muck up the code.

	Robert Love

