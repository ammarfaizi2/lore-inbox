Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJIXqg>; Wed, 9 Oct 2002 19:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJIXqf>; Wed, 9 Oct 2002 19:46:35 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:22400 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S262210AbSJIXqe>; Wed, 9 Oct 2002 19:46:34 -0400
Date: Thu, 10 Oct 2002 00:51:49 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: Yuji Sekiya <sekiya@sfc.wide.ad.jp>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021010005149.A4699@edi-view1.cisco.com>
References: <20021009234421.J29133@edinburgh.cisco.com> <20021009.161414.63434223.davem@redhat.com> <20021010002902.A3803@edi-view1.cisco.com> <20021009.162438.82081593.davem@redhat.com> <uu1jv9o3j.wl@sfc.wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <uu1jv9o3j.wl@sfc.wide.ad.jp>; from sekiya@sfc.wide.ad.jp on Thu, Oct 10, 2002 at 08:41:52AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 08:41:52AM +0900, Yuji Sekiya wrote:
> 
> The reason we change the prefix length  from /10 to /64 is
> following spec and adapting other imprementations.

I said I wouldn't comment futher on the spec issue.

I know of at least one other implementation that allows any set of bits
within the link local range to be specified.  (Two if you include the
current/previous Linux behaviour :-)

Changing to restrict the allowed link local addresses doesn't _enhance_
interoperability.  Leaving it as it is/was doesn't harm anything.

DF
