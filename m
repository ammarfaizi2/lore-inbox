Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVHHSKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVHHSKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVHHSKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:10:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51620 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932147AbVHHSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:10:00 -0400
Subject: Re: Lost Ticks on x86_64
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Tim Hockin <thockin@hockin.org>, Erick Turnquist <jhujhiti@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050808120125.GD19170@wotan.suse.de>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
	 <p73mznuc732.fsf@bragg.suse.de> <20050807174811.GA31006@hockin.org>
	 <20050808120125.GD19170@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 14:09:58 -0400
Message-Id: <1123524598.15269.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 14:01 +0200, Andi Kleen wrote:
> > Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
> > level.
> 
> Doing so would be wasteful though. Both AMD and Intel CPUs need SMM code
> for the deeper C* sleep states.
> 

Wouldn't it be useful for !CONFIG_PM?  Many multimedia users run this
way because they want their machines running full speed all the time
(they need the horsepower, plus frequency scaling interferes with the
TSC based timing used by JACK ) and because ACPI has a history of
causing nasty latency blips.

Lee

