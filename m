Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUJNM0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUJNM0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 08:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUJNM0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 08:26:12 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:52446 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263770AbUJNM0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 08:26:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: unkillable process
References: <1097731227.2666.11264.camel@cube>
From: Johan Kullstam <kullstj-ml@comcast.net>
Organization: none
Date: 14 Oct 2004 08:26:08 -0400
In-Reply-To: <1097731227.2666.11264.camel@cube>
Message-ID: <87r7o1h4f3.fsf@sophia.axel.nom>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> It's really bad when a task group leader exits.
> The process becomes unkillable.

I have been having zombie problems since 2.6.9-rc1.  I run a boinc
climateprediction program (related to seti@home) which leaves defunct
"cp" processes about.  Killing the climatepredictor (called
hadsm3um_4.03_i686-pc-linux-gnu) which spawns them causes these zombie
cp things to get reaped.

> This is with the 2.6.8-rc1 kernel. I haven't seen
> any mention of this getting fixed since then.
> Here's the top of the /proc/*/status file:

I tried it with 2.6.9-rc3 just now and it doesn't make zombies for
me.

climateprediction still makes defunct cp.

(I fired up 2.6.9-rc4 but it somehow wouldn't load the driver for my
ethernet 3c59x.  That's another issue, but I have no idea if the
problem has been fixed there since I am stopped by another problem.)

I skimmed over the changelogs but I have found anything looking like a
change in this area.  I am not sure what the right keyword(s) to
search for on this topic would be.  I didn't grovel through them yet,
but perhaps someone on the list knows what is going on.

-- 
Johan KULLSTAM
