Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSE1Gu0>; Tue, 28 May 2002 02:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSE1GuZ>; Tue, 28 May 2002 02:50:25 -0400
Received: from ns.tasking.nl ([195.193.207.2]:25610 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S312962AbSE1GuZ>;
	Tue, 28 May 2002 02:50:25 -0400
Date: Tue, 28 May 2002 08:48:00 +0200
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8: nf_hook: hook 0 already set
Message-ID: <20020528084800.A18018@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen this twice in /var/log/messages, every time just after
establishing a PPP link:

May 27 23:48:14 espoo pppd[11626]: pppd 2.4.1 started by ppp, uid 15
May 27 23:48:14 espoo pppd[11626]: Using interface ppp0
May 27 23:48:14 espoo pppd[11626]: Connect: ppp0 <--> /dev/pts/0
May 27 23:48:14 espoo pppd[11626]: CHAP peer authentication succeeded for iapetus.localdomain
May 27 23:48:15 espoo pppd[11626]: found interface eth0 for proxy arp
May 27 23:48:15 espoo pppd[11626]: local  IP address 172.17.1.64
May 27 23:48:15 espoo pppd[11626]: remote IP address 172.17.3.1
May 27 23:48:15 espoo pppd[11626]: Deflate (15) compression enabled
May 27 23:51:18 espoo kernel: nf_hook: hook 0 already set. 
May 27 23:51:18 espoo kernel: skb: pf=0 (unowned) dev=eth0 len=46 


-- 
Frank
