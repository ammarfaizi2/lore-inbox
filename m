Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbREXP4r>; Thu, 24 May 2001 11:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbREXP4h>; Thu, 24 May 2001 11:56:37 -0400
Received: from www.microgate.com ([216.30.46.105]:29969 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262119AbREXP4c>; Thu, 24 May 2001 11:56:32 -0400
Message-ID: <003b01c0e472$6f7a3ae0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <rjd@xyzzy.clara.co.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200105241530.f4OFUdw27786@xyzzy.clara.co.uk>
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
Date: Thu, 24 May 2001 10:56:11 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: <rjd@xyzzy.clara.co.uk>
> Linux syncppp does not have a LCP_STATE_REQ_SENT ...
[snip]
> Who's the owner for syncppp.c ?  I might be able to put some time in on
> it, but would hate to be sending patches into empty space.

I'm not sure anyone is willing to claim ownership :)

I did not realize that syncppp does not implement
all the RFC1661 states. That's simply broken :(
A proper state machine implementation would be nice.

On the other hand, it works in a minimal way
for most people and it's supposed to be folded
into the generic PPP implementation someday.
So there's not much point in trying to overhaul the code.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


