Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWIMUmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWIMUmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWIMUmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:42:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6831 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751180AbWIMUmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:42:06 -0400
In-Reply-To: <20060913202029.GA4666@ms2.inr.ac.ru>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Jeff Layton <jlayton@poochiereds.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netdev-owner@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to sockets	that
 are joined to group
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OFD3BF4B0D.1F917BE2-ON882571E8.00716451-882571E8.0071B6B7@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 13 Sep 2006 13:42:02 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 09/13/2006 14:42:05,
	Serialize complete at 09/13/2006 14:42:05
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> wrote on 09/13/2006 01:20:29 PM:

> Hello!
> 
> > IPv6 behaves the same way.
> 
> Actually, Linux IPv6 filters received multicasts, inet6_mc_check() does
> this.

        No, it returns 1 (allow) if there are no filters to explicitly
filter it. I wrote that code. :-)
                                                        +-DLS

