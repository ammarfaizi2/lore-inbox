Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRLJF14>; Mon, 10 Dec 2001 00:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286162AbRLJF1o>; Mon, 10 Dec 2001 00:27:44 -0500
Received: from pcow028o.blueyonder.co.uk ([195.188.53.124]:5899 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S281504AbRLJF1f>;
	Mon, 10 Dec 2001 00:27:35 -0500
Date: Mon, 10 Dec 2001 04:48:49 +0000
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: slow read performance...
Message-Id: <20011210044849.538c84c6.spyro@armlinux.org>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've just run bonnie (Im curious :) and got some disappointing figures.

Im running a Duron @ 976MHz, on an ASUS A7M (76x northbridge, via 686B
southbridge)

the machine has 256MB RAM and a seagate ST320413A UDMA 100 harddisc as the
only device on the primary ide interface.

UDMA is /on/, and all in hdparm looks OK - 32 bit IO etc.

write speed is fine (22-30MB/sec) but reads are horribly slow, as little as
9MB/sec and I havent seen >16MB/sec yet.

I am using a 400MB test in bonnie to remove linuxs disc cache from the
equation, as suggested by someone here.

I thought HDDs were supposed to /read/ faster than they write?

if 9MB/sec normal? seems low... I thought UDMA 100 discs were up around the
30MB/sec mark for reads...

or does bonnie just report unrealistic read speeds? the machine 'feels'
responsive enough...

TIA...
