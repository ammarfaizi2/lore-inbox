Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132794AbRA0S4E>; Sat, 27 Jan 2001 13:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132951AbRA0Szy>; Sat, 27 Jan 2001 13:55:54 -0500
Received: from quechua.inka.de ([212.227.14.2]:62576 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132794AbRA0Szl>;
	Sat, 27 Jan 2001 13:55:41 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-Id: <E14MaVf-0003Cb-00@sites.inka.de>
Date: Sat, 27 Jan 2001 19:55:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A713B3F.24AC9C35@idb.hist.no> you wrote:
>> Think of yourself as a firewall author now.  You come across this, and
>> go, "these bits aren't used now; this means noone should be setting
>> them.  I have no guarantee that anything in the future isn't going to use
>> these bits for something that isn't going to override the security of my
>> system."

> So, no reason for a firewall author to check these bits.

Read it again.

Firewalls must drop Data which is violating the protocol and they must in
Addition to that even drop Data which is not violating the protocol but beeing
suspicious of triggering errors at the receiver side. And Reserved Bit's are
clearly a Thing you, as a Firewall Vendor will block as long as you don't be
sure that the computers you want to secure don't break.

A good example are valid (according to the protocol) chars in email addressses
like '!'. Even if it is perfectly valid you will not consider a firewall do
pass it, or?

Well, of course the best solution would be to make this configurable, but I
guess thats a problem ith recent commercial Firewalls, they promise PnP
security and dont want to confuse the users with too many settings.

After all it is a good idea to leave some decisions to educated professionals
than to normal Firewall admins.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
