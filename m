Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTECS1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTECS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:27:48 -0400
Received: from rth.ninka.net ([216.101.162.244]:32488 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263361AbTECS1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:27:46 -0400
Subject: Re: DECNET in latest BK
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030503175913.GA13595@work.bitmover.com>
References: <20030503175913.GA13595@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051987091.14504.9.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 11:38:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-03 at 10:59, Larry McVoy wrote:
> Doesn't build, I didn't config it out by mistake.  Dunno if anyone uses
> decnet.
> 
> net/decnet/dn_route.c: In function `dn_route_output_slow':
> net/decnet/dn_route.c:1058: `flp' undeclared (first use in this function)

Turn off CONFIG_DECNET_ROUTE_FWMARK, aparently even the maintainer
doesn't even enable this option :-)

-- 
David S. Miller <davem@redhat.com>
D
