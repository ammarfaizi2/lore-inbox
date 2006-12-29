Return-Path: <linux-kernel-owner+w=401wt.eu-S1753559AbWL2FAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbWL2FAQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWL2FAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:00:16 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:32724 "EHLO
	asav06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbWL2FAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:00:15 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CABcwlEVKhRO4UGdsb2JhbACOAAEBKg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Rene Herman <rene.herman@gmail.com>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Date: Fri, 29 Dec 2006 00:00:12 -0500
User-Agent: KMail/1.9.3
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <4592E685.5000602@gmail.com> <200612282240.00784.dtor@insightbb.com> <459497A3.8080001@gmail.com>
In-Reply-To: <459497A3.8080001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612290000.12791.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 23:20, Rene Herman wrote:
> Dmitry Torokhov wrote:
> 
> > The change to suppress ACKs from paic blinking is already in Linus's
> > tree. I just tried booting with root=/dev/sdg and I had leds blinking
> > but no messages from atkbd were seen.
> > 
> > Could it be that you loaded older kernel by accident? Does anybody
> > else still seeing "Spurios ACK" messages during kernel panic?
> 
> Well, no, I'm really on 2.6.20-rc2, from a freshly cloned tree. And I do 
> get atkbd.c complaining at me when I boot with root=/dev/wrong-device.
> 
> Could you point me to the changeset in question? I couldn't find it 
> searching for "leds" in the log.
>

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=817e6ba3623de9cdc66c6aba90eae30b5588ff11
 
-- 
Dmitry
