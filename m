Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTIIMDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbTIIMDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:03:16 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:25736 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264072AbTIIMDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:03:15 -0400
Date: Tue, 9 Sep 2003 14:03:13 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.0-test5-mm1] Fix build with debug disabled
In-Reply-To: <Pine.LNX.4.56.0309091317320.9188@dot.kde.org>
Message-ID: <Pine.LNX.4.51.0309091358350.14559@dns.toxicfilms.tv>
References: <Pine.LNX.4.56.0309091317320.9188@dot.kde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> 2.6.0-test5-mm1 mm/slab.c defines dbg_redzone1 and friends in #if DEBUG,
> but uses them unconditionally.

> Patch attached.
Could you create directories in your people/akpm/* directory for patches
that are accepted/needed/bugfixes/whatever sent for -mm patches after you
submit the respective patch?

Like:
.../people/akpm/patches/2.6/2.6.0-test5-mm1/pending/01_debugfix_patch.diff
.../people/akpm/patches/2.6/2.6.0-test5-mm1/pending/02_other_bugfix.diff

Those would be applied over test5-mm1 to get it going, before you publish
newer patches.

Is this fine with you?

I think that testers would be happy with that.

Regards,
Maciej
