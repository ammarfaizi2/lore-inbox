Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDCRJ2 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261440AbTDCRJ2 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:09:28 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:55542 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S261404AbTDCRIM 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:08:12 -0500
Subject: New version of radeonfb for 2.4, please test !
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: ajoshi@unixbox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049390587.796.51.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Apr 2003 19:23:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks !

I made a patch (against current Marcelo bk) that contains a bunch
of fixes to the radeonfb driver. Among others, it includes new
PCI IDs, fix problem with some TFT panels, fix 800x600 mode
acceleration, and so on... It also brings the PowerMac PM code
up to date.

Please, test it and let me know, especially if I broke an existing
working setup. If it didn't work for you before and still doesn't
let me know of course too, but I don't expect that to delay a
merge with Marcelo.

This driver have been diffing for too long, with patches too
scattered, this is an attempt to consolidate all. Without news
from Ani in the upcoming week(s), I'll probably just consider
myself as the new maintainer for this driver.

Patch can be found at http://penguinppc.org/~benh/radeonfb_ben.diff

Please, send me comments asap, as I intend to ask Marcelo to
merge this version soon. I'll send those patches to James directly
for the 2.5 version since the port in there seem to already be the
one I did a few monthes ago.

Ben.


