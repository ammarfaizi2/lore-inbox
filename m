Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272487AbTHNRFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272539AbTHNRFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:05:49 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:47744 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272487AbTHNRFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:05:48 -0400
Date: Thu, 14 Aug 2003 18:16:41 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308141716.h7EHGfqg000643@81-2-122-30.bradfords.org.uk>
To: rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After reviewing the /proc/kcore and kclist issues, I've decided that I'm
> > no longer prepared to even _think_ about supporting /proc/kcore on ARM -
>
> I suspect we should just remove it altogether.
>
> Does anybody actually _use_ /proc/kcore? It was one of those "cool 
> feature" things, but I certainly haven't ever used it myself except for 
> testing, and it's historically often been broken after various kernel 
> infrastructure updates, and people haven't complained..
>
> Comments?

I've used it on a few rare occasions for last-ditch data recovery
before, E.G. an application crashed that had a text file held in RAM
that wasn't ever written to disk.  Poking through /proc/kcore could
allow it's recovery.

Probably not a sufficent reason to keep it :-).

John.
