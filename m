Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269516AbUJLIUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269516AbUJLIUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUJLIUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:20:49 -0400
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:58752 "EHLO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with ESMTP
	id S269516AbUJLIUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:20:48 -0400
Date: Tue, 12 Oct 2004 10:20:47 +0200
From: Vitez Gabor <vitezg@niif.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Vincent Hanquez <tab@snarc.org>, linux-kernel@vger.kernel.org
Subject: Re: forcedeth: "received irq with unknown events 0x1"
Message-ID: <20041012082047.GA17313@swszl.szkp.uni-miskolc.hu>
References: <20041011145104.GA9494@swszl.szkp.uni-miskolc.hu> <20041011154950.GA22553@snarc.org> <416AB99E.1020407@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <416AB99E.1020407@colorfullife.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 06:49:34PM +0200, Manfred Spraul wrote:
> Vincent, could you try the attached patch? The critical change is the 
> media detection: Test that the nic handles booting without a network 
> cable and then attaching the network cable when the interface is already 
> up correctly.

I patched my kernel, and I'm still baffled: when I connect the E1000 and the
nvidia card, both of them say the link is down. The E1000 and the 3Com card
works well. The E1000 is supposed to do polarity detection, so it should
work with the nvidia card, too. ??

Not really a problem, but I find it pretty strange.

	Gabor
