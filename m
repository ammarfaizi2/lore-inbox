Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTIPNzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTIPNzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:55:55 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34833 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261884AbTIPNzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:55:53 -0400
Date: Tue, 16 Sep 2003 09:46:42 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <jamie@shareable.org>
cc: richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <20030916115050.GG26576@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.3.96.1030916094133.26515A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Jamie Lokier wrote:

> richard.brunner@amd.com wrote:
> > My concern is trying to prevent 
> > the flood of emails where someone thinks they built 
> > a "standard" kernel only to  discover that they forgot 
> > to select the various suboptions
> > and it doesn't work on their processor. I'd like
> > to simplfy what the majority of folks need to do
> > to get a broadly working kernel.
> 
> There's a similar situation with workarounds for buggy IDE chipsets,
> CMD640 and RZ1000

I'm not sure which way you're going here, those have their own config
entries, does that mean that you are advocating just making the Athlon
fixup a config option the user must set, or that all of these should be
on by default and appear in the delete-features menu, and/or be
controlled by my proposed option to build only for the target CPU. Or
was this just an informational comment?

I'm not looking to disagree with any of those suggestions, if you were
making one.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

