Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSCKTn2>; Mon, 11 Mar 2002 14:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSCKTnS>; Mon, 11 Mar 2002 14:43:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:47375 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290277AbSCKTnL>;
	Mon, 11 Mar 2002 14:43:11 -0500
Subject: Re: [PATCH] KERN_INFO 2.4.19-pre2 IP/TCP hash table size printks
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20020311.060324.69703263.davem@redhat.com>
In-Reply-To: <200203111359.g2BDx1q05409@Port.imtp.ilyichevsk.odessa.ua> 
	<20020311.060324.69703263.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 11 Mar 2002 14:43:03 -0500
Message-Id: <1015875785.928.45.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-11 at 09:03, David S. Miller wrote:

> Maybe it is even better idea to change default kernel printk
> logging level which is used when no KERN_* is specified, eh?

Only if we really consider the printks in question "whatever the default
is."  The default has changed before and may change again (as you are
suggesting).  I have no problem changing the default - I just think if
Denis suggests a printk should be classified as "informative" and we
agree, let's change it.  Although I don't think it would fly with Linus,
any printk we can solidly classify we should, imo.

This doesn't preclude changing the default, as you suggest, especially
if its clearly too high.  But I don't see why we shouldn't be explicit
where possible.  No?

	Robert Love

