Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276990AbRJHQTG>; Mon, 8 Oct 2001 12:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276981AbRJHQSr>; Mon, 8 Oct 2001 12:18:47 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50948 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276978AbRJHQSg>; Mon, 8 Oct 2001 12:18:36 -0400
Date: Mon, 8 Oct 2001 12:19:03 -0400
Message-Id: <200110081619.f98GJ3810641@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles
X-Newsgroups: linux.dev.kernel
In-Reply-To: <23246.1002450342@ocs3.intra.ocs.com.au>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <23246.1002450342@ocs3.intra.ocs.com.au> kaos@ocs.com.au wrote:

| This patch removes the dependency on the top level Makefile and
| seperates UTS_RELEASE from LINUX_VERSION_CODE.  Changing the top level
| Makefile no longer forces a complete recompile.  Changing EXTRAVERSION
| only affects a few files.  Changing VERSION, PATCHLEVEL or SUBLEVEL
| still does a major recompile, no way around that because of the number
| of places that test LINUX_VERSION_CODE and modules that need the kernel
| version string.

  I'll let comments accumulate on this, but it seems to offer hope that
patching a few modules and changing the EXTRAVERSION so they go in their
own directory will not blow off eight minutes of time to recompile.
That's nice, assuming it works.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe

