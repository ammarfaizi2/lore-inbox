Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTIOOH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbTIOOH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:07:28 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:55169 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261399AbTIOOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:07:26 -0400
Date: Mon, 15 Sep 2003 15:21:02 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309151421.h8FEL2Nv001550@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, john@grabjohn.com
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org, piggin@cyberone.com.au,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the model I'm proposing, the 386 kernel would be missing the Athlon
> > workarounds.
>
> This is unworkable unless you also have all the existing models where
> you have fixes for later processors too. 

I'm pretty sure we're talking about two different things - I don't
understand what you mean about all the exisiting models.  Are you
saying that with Adrian's patch we still can't simply include this
workaround [1] if and only if the user has included Athlon support,
rather than CPU<=Athlon?

[1] Obviously the point isn't just applicable to this work around, but
this is a new one going in.

John.
