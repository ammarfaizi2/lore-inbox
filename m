Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUH2DHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUH2DHq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 23:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUH2DHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 23:07:46 -0400
Received: from mxresolver.pol.net ([63.240.86.230]:14766 "EHLO sq04.pol.net")
	by vger.kernel.org with ESMTP id S267607AbUH2DHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 23:07:32 -0400
Message-ID: <41291.10.250.10.1.1093748699.squirrel@sq04.pol.net>
Date: Sun, 29 Aug 2004 11:04:59 +0800 (PHT)
Subject: Re: rivafb broken again in 2.6.9-rc1
From: "Antonino A. Daplas" <adaplas@pol.net>
To: <agx@sigxcpu.org>, <adaplas@hotpop.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: adaplas@pol.net
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Guido Guenther <agx@sigxcpu.org> wrote:

> Hi,
> The situation of rivafb was constantly improving on
> ppc since 2.6.7, but for
> 2.6.9-rc1 I have to revert the attached part to get
> it to work again (NV17).
> Without this patch the display shows only colored
> vertical stripes and the
> machine crashes.
> Any ideas?

Bummer :-(  I don't think nVidia cards like DirectColor for all archs.
I'll send a patch later to revert DirectColor back to Truecolor mode.
I'm still out of town, but I should be back in several hours.  I'll also
incorporate the patches you submitted.  If this partial reversion still
doesn't work, I'll revert everything back to a known working state.

Thanks for the help.

Tony



