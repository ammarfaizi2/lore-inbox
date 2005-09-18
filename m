Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVIRGeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVIRGeB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIRGeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:34:00 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:21954 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbVIRGd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:33:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R4Dbnb90rHeut7ovxzZZB9kgjAnTZZjeUV/N13g0afy7edoPUSoqd0BotKisbj3oKvU3vIYh6i9Uz4utjPw4HLitY5ImrRqObmI83Banv5AH4kHM5lzM3Iod6IujD/k2fOa63Mif/QcOoO1BAAfzsJq69n9YqEEFZzpFm6jdzOc=
Message-ID: <12c511ca050917233313418638@mail.gmail.com>
Date: Sat, 17 Sep 2005 23:33:57 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: tony.luck@gmail.com
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Cc: linville@tuxdriver.com, kaos@sgi.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <20050917.232304.31192760.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <25288.1126596450@kao2.melbourne.sgi.com>
	 <12c511ca05091708476aa136cd@mail.gmail.com>
	 <20050917155911.GB19854@tuxdriver.com>
	 <20050917.232304.31192760.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It fixes the problem, but it's a hack, and I, perhaps like Tony,
> personally would like to know why the these IA64 systems break for
> such a simple operation such as writing some base registers with
> values we've probed already.

It does sound odd[1] that you can't rewrite the BARs to the values that
they should already have.  But I'm willing to wait to see what SGI's
solution that fixes this inside arch/ia64/sn/ looks like before making
any judgements.

-Tony

[1] odd == PCI spec violating?
