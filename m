Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbRFTVCE>; Wed, 20 Jun 2001 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbRFTVBy>; Wed, 20 Jun 2001 17:01:54 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:20940 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263225AbRFTVBs>; Wed, 20 Jun 2001 17:01:48 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Jan Hudec" <bulb@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: Client receives TCP packets but does not ACK
Date: Wed, 20 Jun 2001 14:01:34 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKCENCPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
In-Reply-To: <20010618135018.A12320@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Btw: can the aplication somehow ask the tcp/ip stack what was
> actualy acked?
> (ie. how many bytes were acked).

	No, and you shouldn't want to know. Even if the other end ACKed the data,
that doesn't mean that the application on the other end didn't crash. So it
won't tell you what you want to know, which is 'did the application on the
other end process the data?'.

	Application-level guarantees can only be provided by application-level
code.

	DS

