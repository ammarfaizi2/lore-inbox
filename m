Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291005AbSBGASF>; Wed, 6 Feb 2002 19:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291000AbSBGARQ>; Wed, 6 Feb 2002 19:17:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290984AbSBGARD>; Wed, 6 Feb 2002 19:17:03 -0500
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Thu, 7 Feb 2002 00:26:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6192A5.911D5B4F@nortelnetworks.com> from "Chris Friesen" at Feb 06, 2002 03:31:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YcOK-0006wT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I ran into a somewhat related issue on a 2.2.16 system, where I had an app that
> was calling sendto() on 217000 packets/sec, even though the wire could only
> handle about 127000 packets/sec.  I got no errors at all in sendto, even though
> over a third of the packets were not actually being sent.

That is correct UDP behaviour
