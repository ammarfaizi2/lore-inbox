Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUD1OIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUD1OIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbUD1OH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:07:56 -0400
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:20228
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S264789AbUD1OFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:05:30 -0400
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Marc Boucher <marc@linuxant.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, pmarques@grupopie.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       malda@slashdot.org, c-d.hailfinger.kernel.2004@gmx.net,
       Linus Torvalds <torvalds@osdl.org>, jon787@tesla.resnet.mtu.edu
In-Reply-To: <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com>
References: <20040427165819.GA23961@valve.mbsi.ca>
	 <1083107550.30985.122.camel@bach>
	 <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com>
	 <1083117450.2152.222.camel@bach>
	 <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain
Message-Id: <1083161029.3788.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 28 Apr 2004 10:03:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 23:28, Marc Boucher wrote: 
> We generally prefer to focus on making stuff work for users,
> rather than waste time arguing about controversial GPL politics.

Well, as one of your customers (I am a paid/licensed user of your
Conexant modem drivers for my Dell D800) I am completely turned off by
this.  I use a myriad of different binary drivers on various Linux
systems, things like the NVidia binary driver, EMC PowerPath, VMware
binary module, etc.  EMC PowerPath compares well to your example as it
consist of multiple modules and each one spits out a message.  EMC
simply used their documentation to tell the user that these messages
means that the kernel can no longer be supported by the Linux community,
however, they can be safely ignored.

> I would like however to point out that part of the reason why people
> sometimes resort to such kludges is that some kernel maintainers have
> been rather reluctant to accommodate proprietary drivers which
> unfortunately are a necessary real-world evil

In my opinion your actions also represent a real-world evil.  As a user
I'm reluctant to use proprietary drivers and certainly don't expect the ones
that I am forced to used to lie about that fact and try to pretend to be GPL
when they are not.  After reading this I realized that I myself have probably
reported kernel BUG's while your drivers were loaded, not realizing that my
kernel was really tainted because it didn't report that fact.  Who knows how
many other users may have done the same thing?

You seem to think that acceptance of Linux is somehow more important that the
GPL.  In my opinion it's exactly the opposite, acceptance and recognition of
the the importance of the GPL and the rights it gives you is more important
than the acceptance of Linux.  If the "real-world" forces you to do something
that gives up those rights (loading a binary module) the kernel should definitely
make the user aware.

Later,
Tom


