Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTH2RpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTH2RpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:45:13 -0400
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:19139 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S261903AbTH2RnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:43:17 -0400
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables
	getting plugged in and out
From: "Bryan O'Sullivan" <bos@keyresearch.com>
To: David T Hollis <dhollis@davehollis.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <3F4EB641.3040107@davehollis.com>
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
	 <20030829003426.GF12249@vitelus.com>  <3F4EB641.3040107@davehollis.com>
Content-Type: text/plain
Message-Id: <1062178992.12285.130.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Aug 2003 10:43:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 19:11, David T Hollis wrote:

> Hmm, that seems to raise the question - why doesn't dhclient just handle 
> that?

Because it has as little knowledge of how the OS works as possible. 
It's intended to run on all kinds of Unix platforms, not just Linux.

> On a DHCP interface, it's running anyway.  if it paid attention 
> to link status, it would know when to re-request an IP.

There are no cross-platform standards for this kind of thing, so they'd
need modules for Linux, FreeBSD, Solaris, AIX, etc., etc.  I'm sure
they'd be happy to accept patches.

	<b

