Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289887AbSAWPnx>; Wed, 23 Jan 2002 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSAWPno>; Wed, 23 Jan 2002 10:43:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5639 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S289887AbSAWPnd>; Wed, 23 Jan 2002 10:43:33 -0500
Date: Wed, 23 Jan 2002 16:43:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: mochel@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: driver-model.txt
Message-ID: <20020123154314.GA8536@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You need to specify from what context (process, interrupt) are
suspend/resume driver methods called. I guess that at least some of
them need to be called for process context. It would be also nice to
specify which locks may be held by probe/resume routines.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
