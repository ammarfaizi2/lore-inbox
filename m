Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVJAESg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJAESg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 00:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJAESg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 00:18:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:58262 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750727AbVJAESg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 00:18:36 -0400
Subject: error in 2.6.14-rc2/rc3 ipw2200 driver
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 06:18:26 +0200
Message-Id: <1128140307.13334.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello... i have a problem with the ipw2200 driver now merged into
2.6.14-rc2..

it says in dmesg many things..

eth1 (WE) : Driver using old /proc/net/wireless support, please fix
driver !
ipw2200: failed to send RTS_THRESHOLD command
ipw2200: failed to send FRAG_THRESHOLD command
fglrx: Unknown symbol verify_area
ipw2200: failed to send POWER_MODE command
ipw2200: failed to send TX_POWER command
ipw2200: failed to send RTS_THRESHOLD command
ipw2200: No space for Tx
ipw2200: failed to send FRAG_THRESHOLD command
ipw2200: No space for Tx
ipw2200: failed to send POWER_MODE command
ipw2200: No space for Tx
ipw2200: failed to send TX_POWER command

the thing about using /proc/net/wireless comes a million times :) but
that doesent matter..

however, i also get more messages, i am unable to connect to a wireless
network right now, but whenever i do, it says that a firmware error
occurs, and that it restarts - it works fine, however i get this.. i
didnt using the ipw2200 module when it wasnt merged..


also, why merge version 1.0.0? this release gives many headaches, it
doesent work right, and doesent have monitor mode..

also, how come when i even myself replace ieee80211 and ipw2200 with
latest release, and compile, monitor mode doesent work? this seems odd..


i dont mean to be annoying or complain, but there are alot out there
with ipw2200.. and it just doesent work with all features in 2.6.14-rc2
(and i dont see any ipw2200/ieee80211 changes in rc3)

i would be very happy if you could update/fix the driver in the kernel,
it does not matter to me which version, just that it works, and monitor
mode would be really nice too..

thanks.

