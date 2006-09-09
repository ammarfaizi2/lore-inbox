Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWIIPdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWIIPdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWIIPdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:33:25 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:27129 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S932264AbWIIPdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:33:24 -0400
Date: Sat, 9 Sep 2006 17:33:19 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <2006-09-09-17-18-13+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006-09-09-17-18-13+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
Content-Transfer-Encoding: 8bit
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-09-17-33-21+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9/09, Samuel Tardieu wrote:

| We have 44 instances of ENOIOCTLCMD in other watchdog drivers
| and zero instances of ENOTTY. Should we change all the instances, adopt
| what has been done or just change the new ones?

Ok, I've found http://tinyurl.com/pmsqm where you explain that
ENOIOCTLCMD should never be seen by the user. Patch follows to change
the other watchdogs.

