Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRDQOb4>; Tue, 17 Apr 2001 10:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRDQObr>; Tue, 17 Apr 2001 10:31:47 -0400
Received: from quechua.inka.de ([212.227.14.2]:9052 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132674AbRDQObc>;
	Tue, 17 Apr 2001 10:31:32 -0400
Date: Tue, 17 Apr 2001 16:31:11 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: ARP responses broken!
Message-ID: <20010417163111.A20874@lina.inka.de>
In-Reply-To: <E14pWQ2-0005LM-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14pWQ2-0005LM-00@calista.inka.de>; from Mailer-Daemon@lina.inka.de on Tue, Apr 17, 2001 at 04:25:26PM +0200
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but why would you want it to reply for the IP of the other interface even if
> it was NOT on the same subnet?

Because Linux is always answering to all its local IP addresses, regardless
of the Network interface. Even if you tun off the IP Forwarding.

This is by Designs, there are situation where this is good and there are
situations where it is not so good. But it's an old tradition.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
