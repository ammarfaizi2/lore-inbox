Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTHTUI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTHTUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:08:58 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4871 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262191AbTHTUI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:08:56 -0400
Message-ID: <00a501c36756$b536ed30$c801a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: <dang@fprintf.net>, <alan@lxorguk.ukuu.org.uk>,
       <richard@aspectgroup.co.uk>, <skraw@ithnet.com>, <willy@w.ods.org>,
       <carlosev@newipnet.com>, <lamont@scriptkiddie.org>,
       <marcelo@conectiva.com.br>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <layes@loran.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030820150110.15623A-100000@gatekeeper.tmr.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Wed, 20 Aug 2003 22:07:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think anyone is asking for a change in the default behaviour
> (although my point about breaking modules does apply), people would be
> satisfied, even ecstatic, if we had a simple way (flag) to set to make
> Linux work without setting /proc filters, using arpfilter, applying source
> routes (David's suggestion) and generally jumping through hoops.
Agree! Just a flag (ARP_ISOLATED, default to 0) in
/proc/sys/net/ipv4/conf/*? The default behaviour of the current (and future
kernels) stays as it is now, so it doesn't break for anyone, and a lot of
people (including me :) benefit from a much easier setup.

No need to implement a whole hidden scenario either.

Regards,
Bas



