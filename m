Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTE0PXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTE0PXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:23:17 -0400
Received: from holomorphy.com ([66.224.33.161]:4326 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263723AbTE0PXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:23:15 -0400
Date: Tue, 27 May 2003 08:36:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: DevilKin-LKML <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527153619.GJ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271729.49047.devilkin-lkml@blindguardian.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 15:05, William Lee Irwin III wrote:
>> I suspect you're attempting to shoot yourself in the foot. .config?

On Tue, May 27, 2003 at 05:29:48PM +0200, DevilKin-LKML wrote:
> Ah, quite. I saw NUMA was activated, and disabling it fixed my problem. Odd 
> though, that it should become active just by doing a 'make oldconfig' with my 
> 2.7.69 config file...
> Anywayz, it works, this kernel solves all my outstanding issues sofar (being 
> mostly with the irda) so I'm happy :P

It should be even more obscure than that; CONFIG_X86_NUMAQ is basically
"you had _better_ have this machine and you had _better_ know what you're
doing even if you have one".

At any rate, one of us will look at making the option at least harder to
accidentally turn on.


-- wli
