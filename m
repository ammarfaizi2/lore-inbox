Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVKCSNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVKCSNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbVKCSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:13:12 -0500
Received: from mail.ispwest.com ([216.52.245.18]:52486 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1030403AbVKCSNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:13:11 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <cff2d7595303438db8feb9237d6c835b.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: "Mitchell Blank Jr" <mitch@sfgoth.com>,
       "Patrick McHardy" <kaber@trash.net>
CC: "Herbert Xu" <herbert@gondor.apana.org.au>, jschlst@samba.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c;kernel 2.6.14
Date: Thu, 3 Nov 2005 10:13:04 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy
> Mitchell Blank Jr wrote:
> > Well the original author presumably thought that the fast-path of
> > load_pointer() was critical enough to keep inline (since it can be run many
> > times per packet)  So they made the deliberate choice of separating it
> > into two functions - one inline, one non-inline.
> 
> Exactly. __load_pointer is only called rarely, while load_pointer is
> called whenever data needs to be read from the packet. It shouldn't
> be changed without any justification.


That's a good enough answer for me!


Thanks


