Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVCDE0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVCDE0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCCTmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:42:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60611 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262526AbVCCTWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:22:53 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Canter <marcus@vfxcomputing.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503031410450.19015@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
	 <1109876978.2908.31.camel@mindpipe>
	 <Pine.LNX.4.62.0503031410450.19015@krusty.vfxcomputing.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 14:22:51 -0500
Message-Id: <1109877771.2908.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I hope you don't mind me re-adding LKML because this illustrates an
important point)

On Thu, 2005-03-03 at 14:15 -0500, Mark Canter wrote:
> Seems like the Q/A process is kind of borked if the below tests are known 
> but don't get applied before it gets released into the wild.

We will never be able to get 100% of these before they get out the door,
because the ALSA developers can't test on every possible hardware.  And
the group of users who test ALSA CVS and ALSA releases before they go in
the kernel is small.

That being said, you are 100% right.  It is widely acknowledged that the
release candidate process is broken.  The solution is to fix the release
candidate process, so more people try the -rcs.  This is the only way to
catch bugs like this before they get out.  Please see the "release
numbering" thread for some proposed solutions.

Lee


