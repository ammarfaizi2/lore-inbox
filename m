Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135633AbREFMRV>; Sun, 6 May 2001 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135634AbREFMRB>; Sun, 6 May 2001 08:17:01 -0400
Received: from main.spectraweb.ch ([194.158.230.44]:10708 "EHLO
	newmail.spectraweb.ch") by vger.kernel.org with ESMTP
	id <S135633AbREFMQx>; Sun, 6 May 2001 08:16:53 -0400
Date: Sun, 6 May 2001 14:14:18 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: very long time for booting after upgrading from 2.2.17 to 2.4.4
Message-ID: <20010506141418.B1274@puck.ch>
Mail-Followup-To: Olivier Bornet <Olivier.Bornet@puck.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010505144533.A1026@puck.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010505144533.A1026@puck.ch>; from Olivier.Bornet@puck.ch on Sat, May 05, 2001 at 02:45:33PM +0200
X-Url: http://puck.ch/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

> I have update my kernel from 2.2.17 (with USB patch) to kernel 2.4.4. Now,
> booting the kernel block for about 5 minutes when configuring lo and eth0.
> 
> ...
> 
> Also, poweroff the system correctly take about 20 minutes. All work good until
> portmap stop. After, all is really slowwwww.

I have found the problem (thanks to Mitch). This is due to have NIS enabled in
nsswitch.conf. Without NIS, boot and shutdown is OK.

When I'm at home, all is OK, because I don't have a NIS server. But when I will
come back at work, I need NIS, so, if someone has a tip on how to also cover
this problem, you are welcome.

Let me know if I'm wrong, be it seem this is due to a change in the kernel
between 2.2 and 2.4.

Good day.

		Olivier
-- 
Olivier Bornet                 |      français : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net
