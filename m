Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUHPLvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUHPLvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUHPLvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:51:42 -0400
Received: from mail505.nifty.com ([202.248.37.213]:3796 "EHLO
	mail505.nifty.com") by vger.kernel.org with ESMTP id S267556AbUHPLvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:51:15 -0400
To: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
From: Tetsuo Handa <a5497108@anet.ne.jp>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
In-Reply-To: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
Message-Id: <200408162049.FFF09413.8592816B@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Mon, 16 Aug 2004 20:51:03 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David.

On Sun, 15 Aug 2004 14:59:52 -0700
David S. Miller wrote:
> On Sun, 15 Aug 2004 16:57:58 -0300
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> > On Sun, Aug 15, 2004 at 01:53:49AM +0900, Tetsuo Handa wrote:
> > > 
> > > I'm using tg3.o with DHCP and PXE boot environment
> > > and I updated from 2.4.26 to 2.4.27,
> > > but tg3.o became not working with IBM BladeCenter.
> > 
> > David Miller is the tg3 maintainer, he will help you.
> 
> Does manual IP configuration work?

'ifconfig eth0 192.168.0.40' and 'route add default gw 192.168.0.1' showed
no error messages, but 'ping' doesn't reply.

 From 2.4.26 till 2.4.27-rc3 were all OK.
This trouble happens with 2.4.27-rc4 and later.

--
I'm sorry, but since yesterday, I temporarily disabled a5497108@anet.ne.jp to reduce spams.
Please reply to dev_null@anet.ne.jp if you couldn't reply to a5497108@anet.ne.jp .
Thank you.
