Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRKOT7X>; Thu, 15 Nov 2001 14:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281023AbRKOT7O>; Thu, 15 Nov 2001 14:59:14 -0500
Received: from colorfullife.com ([216.156.138.34]:62990 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281018AbRKOT7D>;
	Thu, 15 Nov 2001 14:59:03 -0500
Message-ID: <3BF41E5B.38FA019C@colorfullife.com>
Date: Thu, 15 Nov 2001 20:58:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The connection to the server has failed. Account: 'mail.timpanogas.org',
> Server: 'mail.timpanogas.org', Protocol: SMTP, Port: 25, Secure(SSL): No,
> Socket Error: 10061, Error Number: 0x800CCC0E

SMTP is a text protocol - tcpdump (-s 1500 -x -a port 25) the
connection, then you can probably see why is complains.

--
	Manfred
