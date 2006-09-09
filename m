Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWIIPiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWIIPiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWIIPiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:38:14 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:25077 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S932272AbWIIPiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:38:13 -0400
Date: Sat, 9 Sep 2006 17:38:12 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <2006-09-09-17-18-13+trackit+sam@rfc1149.net> <1157817522.6877.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157817522.6877.46.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
Content-Transfer-Encoding: 8bit
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-09-17-38-12+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9/09, Alan Cox wrote:

| This is insufficient. Many watchdog drivers are broken here but that's
| no excuse to continue the problem because people will copy the errror
| (as I suspect you did)
| 
| 	fd = open("/dev/watchdog", O_RDWR);
| 	switch(fork())
| 	{
| 
| .. one open, two users, two processes, two CPUs

Right. Thanks for the review, will fix.

