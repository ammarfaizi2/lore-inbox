Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWAMNOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWAMNOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWAMNOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:14:43 -0500
Received: from postel.suug.ch ([194.88.212.233]:28106 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S964774AbWAMNOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:14:42 -0500
Date: Fri, 13 Jan 2006 14:15:03 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: WCONF, netlink based WE replacement.
Message-ID: <20060113131503.GA379@postel.suug.ch>
References: <200601121824.02892.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601121824.02892.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch <mbuesch@freenet.de> 2006-01-12 18:24
> This is an attempt to rewrite the Wireless Extensions
> userspace API, using netlink sockets.
> There should also be a notification API, to inform
> userspace for changes (config changes, state changes, etc).
> It is not implemented, yet.

I'll only comment on the netlink bits and leave the rest to
others. I'd highly recommend the use of attributes instead
of fixed message structures to allow the interface to be
flexible to extensions while staying binary compatible.

Another idea might be to use the new generic netlink family
to make things a bit easier to use.
