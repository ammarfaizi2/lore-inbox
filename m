Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271235AbTHCStq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271239AbTHCSsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:48:31 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:13730 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S271308AbTHCShn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:37:43 -0400
Date: Sun, 3 Aug 2003 20:37:07 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: sleeping in dev->tx_timeout?
Message-ID: <20030803183707.GA13728@oasis.frogfoot.net>
Mail-Followup-To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 20:34:45 up 28 days, 20:41, 8 users, load average: 0.07, 0.07, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is it safe to sleep in tx_timeout (in the networking code), i.e. to call
schedule_timeout and friends from that routine?

-- 

Regards
 Abraham

: How would you disambiguate these situations?

By shooting the person who did the latter.
             -- Larry Wall in <199710290235.SAA02444@wall.org>

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

