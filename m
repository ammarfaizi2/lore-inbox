Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUG2OFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUG2OFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUG2OFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:05:46 -0400
Received: from styx.suse.cz ([82.119.242.94]:57493 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264692AbUG2OFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:05:40 -0400
Date: Thu, 29 Jul 2004 16:07:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [patches] Input updates
Message-ID: <20040729140728.GA18817@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Again, quite a bunch of patches has accumulated in my tree - now that
they're well tested through Andrew's mm tree, I'd like to merge them to
you.

There still are imperfections in atkbd/psmouse locking, but the races
are rather hard to hit - and it's still better than before. They should
be fixed in the next round of patches, however I'd still like to have
this round of patches in before the next one.

Please pull from bk://kernel.bkbits.net/vojtech/input

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
