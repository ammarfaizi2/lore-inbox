Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTEFFA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEFFA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:00:57 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:46766 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262368AbTEFFA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:00:56 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Add leading underline to new linker-script symbols on the v850
References: <20030506030925.388CC3760@mcspd15.ucom.lsi.nec.co.jp>
	<1052192261.983.10.camel@rth.ninka.net>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 May 2003 14:12:40 +0900
In-Reply-To: <1052192261.983.10.camel@rth.ninka.net>
Message-ID: <buohe88slo7.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> Why are you submitting patches that define flush_page_to_ram() to
> anything?
> 
> That interface is deleted in 2.5.x, no platform should define it and
> nothing in the kernel invokes it.

I think in this case it's because I try to keep the v850 arch files
identical on 2.4.x and 2.5.x (as much as is possible), which sometimes
results in unused #defines on one or the other.

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that
            will  make every christian in the world foamm at the mouth?
[iddt]      nurg, that's the goal
