Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbREXSQs>; Thu, 24 May 2001 14:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbREXSQh>; Thu, 24 May 2001 14:16:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39941 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261738AbREXSQM>; Thu, 24 May 2001 14:16:12 -0400
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
To: paulkf@microgate.com (Paul Fulghum)
Date: Thu, 24 May 2001 19:13:04 +0100 (BST)
Cc: rjd@xyzzy.clara.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <003b01c0e472$6f7a3ae0$0c00a8c0@diemos> from "Paul Fulghum" at May 24, 2001 10:56:11 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152zbc-0005Oz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did not realize that syncppp does not implement
> all the RFC1661 states. That's simply broken :(
> A proper state machine implementation would be nice.

syncppp.c -predates- RFC1661 I believe.

> On the other hand, it works in a minimal way
> for most people and it's supposed to be folded
> into the generic PPP implementation someday.
> So there's not much point in trying to overhaul the code.

I had hoped for 2.4 to use generic ppp with it. That might be the more
productive way to attack the problem

