Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUB0AcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUB0AcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:32:16 -0500
Received: from smtp3.oregonstate.edu ([128.193.0.12]:49342 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261359AbUB0AcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:32:13 -0500
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.1: why auto power-off while on batteries?
Date: Thu, 26 Feb 2004 16:32:10 -0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402261631.14908.EricAltendorf@orst.edu>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since I've upgraded my Fedora 1 distro to 2.6.1+swsusp, I've noticed 
that while on battery power (and only then), the laptop will auto 
poweroff after about 5 minutes of inactivity.  This does not appear 
to be a user-level acpid/whatever clean shutdown; the power is just 
cut without so much as a disk sync.  Of course there are no entries 
in /var/log/messages.

Any ideas anyone?

-- 
Eric Altendorf    //    http://www.speedtoys.com/~eric

