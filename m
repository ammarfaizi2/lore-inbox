Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265117AbUELQLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUELQLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUELQLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:11:32 -0400
Received: from mail.tmr.com ([216.238.38.203]:20232 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265117AbUELQLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:11:08 -0400
Date: Wed, 12 May 2004 12:07:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@osdl.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
In-Reply-To: <20040511165013.08ef86cd.akpm@osdl.org>
Message-ID: <Pine.LNX.3.96.1040512115750.23213A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Andrew Morton wrote:

> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> >
> > There was some evidence from AKPM (and Arjan AFAIR).
> > [ BTW wasn't the corruption only seen with nvidia module? ]
> > I think we can prevent it by adding something ala 4kstack flag
> > to the module.
> 
> "4KSTACKS" already is present in the module version string.
> 
> And RHL is shipping now with 4k stacks, so presumably any disasters
> are relatively uncommon...

RHL and kernel.org have a lot of unshared bugs and features,
unfortunately. I take that information as an encouraging proof of concept,
not a waranty that the kernel.org code will behave in a similar way.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

