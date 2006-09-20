Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWITRVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWITRVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWITRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:21:47 -0400
Received: from xenotime.net ([66.160.160.81]:47547 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932078AbWITRVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:21:46 -0400
Date: Wed, 20 Sep 2006 10:22:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modules.isapnpmap vs modules.alias
Message-Id: <20060920102248.ebb55960.rdunlap@xenotime.net>
In-Reply-To: <20060920185301.21dcf9bc@silver>
References: <20060920185301.21dcf9bc@silver>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 18:53:01 +0200 iSteve wrote:

> Greetings,
> I'm looking at the modules.isapnpmap and I compare it with modules.alias file.
> For example:
> 
> -modules.isapnpmap:
> snd-mpu401           0xffff     0xffff     0x00000000  0xd041     0x06b0
> -EOF
> 
> -modules.alias:
> alias:          pnp:dPNPb006*
> -EOF
> 
> I am trying to resolve the isapnpmap into the alias. I figured most of it, but
> I'm confused by the "PNP" part. It is obvious that vendor 0xd041 conforms to
> "PNP", as all devices that have vendor 0xd041 have PNP and vice versa, similarly
> for eg. vendor 0xa865 and "YMH"... 
> 
> However, how can I actually translate "PNP" to "0xd041" (and/or backwards)?

It's defined in the MS ISA PNP spec from
http://www.microsoft.com/whdc/resources/respec/specs/pnpisa.mspx

I just went thru the bit fiddling exercise, so holler if you
want/need help with it.  (I'd rather just teach you how to fish
instead of giving you fish.)

> Thanks in advance for any reply.
> Please, CC me, as I am not subscribed to the mailing list.

---
~Randy
