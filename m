Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270871AbTGVSu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270876AbTGVSu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:50:28 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:27575 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270871AbTGVSu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:50:27 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Jul 2003 11:58:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: jamie@shareable.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
In-Reply-To: <20030722115823.4b34f9ce.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.55.0307221156180.1372@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
 <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
 <20030722172722.GC3267@mail.jlokier.co.uk> <Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
 <20030722115823.4b34f9ce.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003, Randy.Dunlap wrote:

> On Tue, 22 Jul 2003 10:31:37 -0700 (PDT) Davide Libenzi <davidel@xmailserver.org> wrote:
>
> | On Tue, 22 Jul 2003, Jamie Lokier wrote:
> |
> | > Davide Libenzi wrote:
> | > > IMHO, since "var" is really an output parameter.
> | >
> | > "var" is read, not written.
> | > I think you are confusing "lidt" with "sidt".
> |
> | Actually I don't even know what I was confusing, since L and S are not
> | there for nothing ;) And yes, the form with =m as input parameter should
> | be corrected, even if it generates the same code.
>
> Yes, less confusion is better, so here's a patch to use the
> same reasonable syntax in all places.
>
> Look OK?  Generates the same code, as Davide pointed out.

Yep, that's the right syntax (pls push to Andrew or Linus) ;)



- Davide

