Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVGGNq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVGGNq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVGGNmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:42:32 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:55703 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261519AbVGGNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:42:20 -0400
Date: Thu, 7 Jul 2005 17:41:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050707174158.A4318@jurassic.park.msu.ru>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi> <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi>; from teanropo@cc.jyu.fi on Thu, Jul 07, 2005 at 03:47:58PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:47:58PM +0300, Tero Roponen wrote:
> I just tested the patch, but it didn't help. It still hangs.

Well, the code in setup-bus.c does actually know about host
bridges, so the patch was just no-op...

Tero (and others), can you post dmesg from working kernel and,
if possible, from 2.6.13-rc2 captured from serial console?

Ivan.
