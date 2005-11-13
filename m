Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVKMUXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKMUXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKMUXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 15:23:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65416 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750760AbVKMUXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 15:23:42 -0500
Date: Sun, 13 Nov 2005 12:23:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: ia64 SN2 - migration costs: 1) nearly zero 2) BUG 3) repeated
Message-Id: <20051113122337.2767b84d.pj@sgi.com>
In-Reply-To: <20051113121309.226543ca.pj@sgi.com>
References: <20051112135410.3eef5641.pj@sgi.com>
	<20051112144949.3b331aa1.pj@sgi.com>
	<20051113071716.GA31075@elte.hu>
	<20051113121309.226543ca.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah - no sooner do I send that than I see a key fact.

On this last boot, with no migration_debug and the original config
on a 2.6.14-mm2 kernel, ia64 sn2_defconfig,
 1) The console output to the screen showed one good matrix.
 2) The /var/log/messages file shows six bad (zero'd) matrices.

I have not seen anything these last two days that is inconsistent
with the above two observations.

Presumably this is more some confusion with how the boottime
kernel prints are captured in /var/log/messages than it is
a problem with the migration cost matrix.

The ball is still on my side of the tennis court.  I can't make
out the player on the other side yet through the fog, but I doubt
it's Ingo.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
