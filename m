Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVHHMB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVHHMB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVHHMB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:01:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:48320 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750830AbVHHMB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:01:26 -0400
Date: Mon, 8 Aug 2005 14:01:25 +0200
From: Andi Kleen <ak@suse.de>
To: Tim Hockin <thockin@hockin.org>
Cc: Andi Kleen <ak@suse.de>, Erick Turnquist <jhujhiti@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050808120125.GD19170@wotan.suse.de>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel> <p73mznuc732.fsf@bragg.suse.de> <20050807174811.GA31006@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807174811.GA31006@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
> level.

Doing so would be wasteful though. Both AMD and Intel CPUs need SMM code
for the deeper C* sleep states.

-Andi
