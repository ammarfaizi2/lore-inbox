Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270854AbTG0QAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270855AbTG0QAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:00:34 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12672 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270854AbTG0QAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:00:31 -0400
Date: Sun, 27 Jul 2003 17:22:34 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307271622.h6RGMYAM000533@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, wowbagger@sktc.net
Subject: Re: time for some drivers to be removed?
Cc: linux-kernel@vger.kernel.org, rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That way, a busted item would not be built by default, and the item's 
> users would be motivated to correct it (and thus remove the stigma of 
> the BROKEN flag).

The point is, allyesconfig is NOT the default, and shouldn't ever be
treated as such.  The kernel resulting from an allyesconfig would
typically be too big to boot on i386 anyway.

> If an item stays BROKEN for too long, bu-bye! Obviously no-one cares 
> enough to fix it.

Or has access to the hardware to fix it.  For some rare hardware it
can be almost impossible to buy a replacement for any price, if it
breaks.

John.
