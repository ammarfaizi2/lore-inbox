Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275466AbTHJEBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 00:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275467AbTHJEBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 00:01:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15350 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S275466AbTHJEBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 00:01:48 -0400
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, jmorris@intercode.com.au
In-Reply-To: <20030809204927.46b84c83.davem@redhat.com>
References: <20030809074459.GQ31810@waste.org>
	 <20030809143314.GT31810@waste.org> <1060481247.31499.62.camel@localhost>
	 <20030810031418.GW31810@waste.org>
	 <20030809204927.46b84c83.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1060488099.31499.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sat, 09 Aug 2003 21:01:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 20:49, David S. Miller wrote:

> I definitely agree, removing the integrity of random.c is not
> an option.  Even things inside the kernel itself rely upon
> get_random_bytes() for anti-DoS measures.

OK, fair enough.  I liked the idea because it let things stay optional,
but also gave us no excuse not to merge Matt's changes.

I would have no problem requiring cryptoapi, but what if it increases in
size?  Requiring a large (and definitely oft-used for many people)
feature isn't size, either.

	Robert Love


