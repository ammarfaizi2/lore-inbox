Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUF2TaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUF2TaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUF2TaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:30:18 -0400
Received: from holomorphy.com ([207.189.100.168]:1962 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265950AbUF2TaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:30:15 -0400
Date: Tue, 29 Jun 2004 12:23:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [profile]: [10/23] ia64 profiling cleanups
Message-ID: <20040629192353.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rddunlap@osdl.org
References: <0406220816.0a0a1aMbIbXa5a1aIb1a2aJbYaLbLb5aXaHbZaXaIbXa2aWaJbMbIbZa5a5aZa4a15250@holomorphy.com> <0406220816.Mb0a5a5a5a1a5a3aKbKb0a3a4a0aHbZaIbJbLb5a3aJbHbXaWaMb2aHb0a1aKbWa15250@holomorphy.com> <16609.47965.922863.441817@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16609.47965.922863.441817@napali.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 08:17:09 -0700, William Lee Irwin III <wli@holomorphy.com> said:
William> Convert ia64 to use profiling_on() and profile_tick().

On Tue, Jun 29, 2004 at 11:56:29AM -0700, David Mosberger wrote:
> This patch looks fine to me (well, it took me a while to figure out
> that you hid profiling_on() and profile_tick() inside the ppc32 diff;
> bad boy! ;-).

Ah, yes, I folded the implementation of the API into the conversion
patch for the first user converted. Since this obfuscates the series
when it's later introduced in a large number of places, I'll change that.

Thanks.


-- wli
