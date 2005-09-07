Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVIGXZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVIGXZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 19:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVIGXZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 19:25:26 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:48030 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbVIGXZZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 19:25:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PkjNwXUa147ECft16po795y+5PCUsuEBAIc/NkEoZqtBkjO9OpCBS63IQ6yZ19TTJLX1iwRzDluPmX9gk7uT21MqTAwVZef3TV8i+Z9OggvEMiqGMOE3erlDDdlUbpWYWTmNUe4FCy19BNGhlbnkJ8+cdcBMWbDM0cPf9tyglVU=
Message-ID: <58d0dbf105090716255561d04f@mail.gmail.com>
Date: Thu, 8 Sep 2005 01:25:20 +0200
From: Jan Kiszka <jan.kiszka@googlemail.com>
Reply-To: jan.kiszka@googlemail.com
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfnnn3$8vm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <431F2760.5060904@tmr.com> <58d0dbf10509071054175e82ff@mail.gmail.com>
	 <200509071552.27543.phillips@istop.com>
	 <58d0dbf105090713283aa455e8@mail.gmail.com>
	 <dfnnn3$8vm$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/7, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>:
> Jan Kiszka wrote:
> 
> > Ndiswrapper is already slower than native drivers are, also due to
> > horribly implemented Windows drivers btw (the ndis model itself isn't
> > that bad, though).
> 
> Do you have any evidence to back your claims? What tests did you do to say
> that ndiswrapper is slower than native driver? Under X86-64 there is some
> overhead due to reshuffling of arguments, but it is so little that I doubt
> if it can be measured.

Giri, I'm not attacking your project. You know I'm sharing your
pragmatic view. Performance is a pure technical issue.

Yes, I can provide some numbers around atheros devices (10-20%
speed-up). And yes, I can explain why ndiswrapper suffers from certain
differences of the NDIS driver model compared to the one of Linux
(just consider what had to be moved to tasklets). But I think this
would better be continued on the ndiswrapper list than here.

Jan
