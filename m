Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbTGKFFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 01:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269784AbTGKFFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 01:05:00 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:50309 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S266603AbTGKFE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 01:04:59 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Pekka Savola <pekkas@netcore.fi>
Cc: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.44.0307110750150.24705-100000@netcore.fi>
References: <Pine.LNX.4.44.0307110750150.24705-100000@netcore.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057900800.3588.50.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 08:20:00 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 07:51, Pekka Savola wrote:
> Well, the system may make some sense, but IMHO, there is still zero sense 
> in policing this thing when you add a route.  That's just plain bogus.  
> This is a bug which must be fixed ASAP.

Correct me if I'm wrong but I think in this case the interface had
forwarding enabled and the sanity check in fact prevented a default
route pointing to the node itself from being configured.

Otherwise I fully agree. The subnet router anycast address doesn't
warrant any special handling.

	MikaL

