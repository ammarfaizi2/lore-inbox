Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFPOfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTFPOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:35:24 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:47545 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262171AbTFPOfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:35:20 -0400
Date: Mon, 16 Jun 2003 09:44:44 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@bitmover.com>
Subject: Re: bkSVN live
Message-ID: <20030616134444.GT542@hopper.phunnypharm.org>
References: <20030615133631.GF542@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615133631.GF542@hopper.phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow the logic I had in my python script that was meant to ignore
BitKeeper/* files (not put them in the repo), which worked on the other
two machines I've run this on, seems to be exposing a bug in the python
on kernel.bkbits.net. It did not allow the COPYING file through the
os.path.walk() callbacks, so it was not in the repo as well.

I am not ignoring files anymore...I don't think it hurts anything having
the BitKeeper files. It was only a personal hack I had in place for when
I was using this setup just for myself for the past 3-4 weeks.

Now, Larry and I have our opposing conspiracy theories about why
ignoring the BitKeeper files would cause the GPL license to also be
ignored, but that's a neither here nor there ;)

Fact is, I had to rebuild the repo's. That means a complete re-checkout
for everyone.

Sorry.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
