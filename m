Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWAOUKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWAOUKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAOUKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:10:09 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:31355 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbWAOUKI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:10:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=L1Fs3he7xYH/97CmHI0wKePFclbq+5NWaI2hLdfJM6Q2Ym039m+1+at7EJcdxG0yP0P/LcVkP+6S7rd5jQmQS84wVFnDsO7ZjgUp+t1Mj6gTyPgDX7+OFrRHnNZhSrJ/ryjpmvaYfA4Mw0W+z8rpMYpqSPLbUHKUBZAdU8MIWKk=
Date: Sun, 15 Jan 2006 21:09:48 +0100
From: Diego Calleja <diegocg@gmail.com>
To: "Vitaly V. Bursov" <vitalyb@telenet.dn.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.15.1 ppp_async panic on x86-64.
Message-Id: <20060115210948.4e2990a7.diegocg@gmail.com>
In-Reply-To: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
References: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 15 Jan 2006 21:48:38 +0200,
"Vitaly V. Bursov" <vitalyb@telenet.dn.ua> escribió:

> Hello,
> 
> PPP doesn't work for me on a x86-64 kernel. Kernel panics with a message
> 
> ================cut: dmesg
> Jan 15 20:24:12 vb skb_over_panic: text:ffffffff886700d9 len:1 put:1
> head:ffff81002b7ed000 data:ffff81012b7ed000 tail:ffff81012b7ed001
> end:ffff81002b7ed600 dev:<NULL>
> Jan 15 20:24:12 vb ----------- [cut here ] --------- [please bite here ] ---------
> Jan 15 20:24:12 vb Kernel BUG at net/core/skbuff.c:94
> ================cut


Just for the record, there're more people hitting this
http://bugzilla.kernel.org/show_bug.cgi?id=5857
