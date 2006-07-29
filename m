Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWG2PeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWG2PeY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWG2PeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 11:34:24 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:51891
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750857AbWG2PeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 11:34:23 -0400
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
From: Paul Fulghum <paulkf@microgate.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060728233851.GA35643@muc.de>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <1154112276.3530.3.camel@amdx2.microgate.com>
	 <20060728144854.44c4f557.akpm@osdl.org>  <20060728233851.GA35643@muc.de>
Content-Type: text/plain
Date: Sat, 29 Jul 2006 10:33:59 -0500
Message-Id: <1154187239.3404.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 01:38 +0200, Andi Kleen wrote:

> It's remove-timer-fallback likely. I was working on that already.
> 
> Some boards go into the timer fallback path since 2.6.17/64bit for so 
> far unknown reasons and that doesn't work anymore because I removed the 
> fallback path.

remove-timer-fallback did not reverse cleanly against 2.6.18-rc2-mm1

I tried to patch it up and got it to compile without
errors or warnings. The result was a hard freeze early in
the boot, so I suspect more is necessary to restore that
function.

-- 
Paul Fulghum
Microgate Systems, Ltd

