Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRGTVzm>; Fri, 20 Jul 2001 17:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267420AbRGTVzc>; Fri, 20 Jul 2001 17:55:32 -0400
Received: from dnai-216-15-62-124.cust.dnai.com ([216.15.62.124]:53981 "HELO
	soni.ppetru.net") by vger.kernel.org with SMTP id <S267418AbRGTVzS>;
	Fri, 20 Jul 2001 17:55:18 -0400
Date: Fri, 20 Jul 2001 14:55:44 -0700
To: linux-kernel@vger.kernel.org
Subject: Getting destination address for UDP packets
Message-ID: <20010720145544.D1267@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: ppetru@ppetru.net (Petru Paler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I'm working on a program which binds on all the available interfaces (0.0.0.0)
and listens for/replies with UDP packets.

The problem is that I need to send back responses from the same IP address that
the query arrived to, and this is not usually happening.

Example: supposing I have 1.1.1.2 and 1.1.1.3 aliased on the same interface, and
a query arrives on 1.1.1.3, it's mandatory that the reply packet goes out from
1.1.1.3.

The question is: how do I get (from user space, if possible) the destination
IP address of an UDP packet?

Thanks

Petru
