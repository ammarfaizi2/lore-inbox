Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272284AbRHXSEg>; Fri, 24 Aug 2001 14:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272285AbRHXSEP>; Fri, 24 Aug 2001 14:04:15 -0400
Received: from adsl-64-167-239-139.dsl.scrm01.pacbell.net ([64.167.239.139]:20240
	"EHLO genbukan.no-ip.com") by vger.kernel.org with ESMTP
	id <S272284AbRHXSEN>; Fri, 24 Aug 2001 14:04:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: red0x <red0x@users.sourceforge.net>
Organization: genbukan
To: linux-kernel@vger.kernel.org
Subject: iptables limit and SSH
Date: Fri, 24 Aug 2001 11:03:41 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0108241103410H.03845@playground>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some time ago, I posted a few messages that got rejected by the moderator.

This, hopefully wont.

I was having problems involvine my kernel (2.4.5) dying when i would try
to ssh from my webserver to my local work station (using scp).

Here is what i have discovered so far:

iptables -A INPUT -j LOG -p tcp -i eth0 --syn --dport 22 -m limit --limit
2/s causes a lock up when i try and SSH

Is this a bug or just my missuse of the limit match?

-- 
--red0x
