Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132719AbRDILFO>; Mon, 9 Apr 2001 07:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132720AbRDILFE>; Mon, 9 Apr 2001 07:05:04 -0400
Received: from [212.115.175.146] ([212.115.175.146]:25080 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S132719AbRDILE4>; Mon, 9 Apr 2001 07:04:56 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F1193@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Sources of entropy - /dev/random problem for network servers
Date: Mon, 9 Apr 2001 13:04:47 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However, only 3 drivers in drivers/net actually set
>> SA_SAMPLE_RANDOM when calling request_irq(). I believe
>> all of them should.
> No, because an attacker can potentially control input and make it
> non-random.
AB> 2. Given that otherwise in at least my application (and machine
AB> without keyboard and mouse can't be too uncommon) there is *no*
AB> entropy otherwise, which is rather easier for a hacker. At least

Put a soundcard in your system and install audio-entropyd.
Works pretty nice.
