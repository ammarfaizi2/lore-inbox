Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbSJIXb3>; Wed, 9 Oct 2002 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbSJIXb2>; Wed, 9 Oct 2002 19:31:28 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:61689 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S262106AbSJIXbQ>; Wed, 9 Oct 2002 19:31:16 -0400
Date: Thu, 10 Oct 2002 00:36:28 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: "David S. Miller" <davem@redhat.com>
Cc: sekiya@sfc.wide.ad.jp, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021010003627.A4481@edi-view1.cisco.com>
References: <20021009234421.J29133@edinburgh.cisco.com> <20021009.161414.63434223.davem@redhat.com> <20021010002902.A3803@edi-view1.cisco.com> <20021009.162438.82081593.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021009.162438.82081593.davem@redhat.com>; from davem@redhat.com on Wed, Oct 09, 2002 at 04:24:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:24:38PM -0700, David S. Miller wrote:
>    From: Derek Fawcus <dfawcus@cisco.com>
>    Date: Thu, 10 Oct 2002 00:29:02 +0100
> 
>    There are areas where the TAHI tests expect a certain behaviour
>    when more than one behaviour is acceptable.
> 
> Great, that's what I was trying to find out.
> 
> Now I just need to know if this link-local prefix case
> is one such issue. :-)

That I can't answer,  since I've not had that one specifically thrown at
me as a test failure condition.

However,  in a previous email I did indicate the two different ICMPv6
errors that could be generated.  So I guess it's a case of see if this
was a TAHI failure,  and if so then is it that TAHI want's to get a
'no route to destination' when 'address unreachable' should suffice.

DF
