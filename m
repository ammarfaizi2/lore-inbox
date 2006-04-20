Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWDTTKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWDTTKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDTTKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:10:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28126
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750724AbWDTTKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:10:03 -0400
Date: Thu, 20 Apr 2006 12:09:55 -0700 (PDT)
Message-Id: <20060420.120955.28255828.davem@davemloft.net>
To: simlo@phys.au.dk
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Maybe ask questions like this on "netdev" where the networking
  developers hang out?  Added to CC: ]

Van fell off the face of the planet after giving his presentation and
never published his code, only his slides.

I've started to make a slow attempt at implementing his ideas, nothing
but pure infrastructure so far, but you can look at what I have here:

	kernel.org:/pub/scm/linux/kernel/git/davem/vj-2.6.git

don't expect major progress and don't expect anything beyond a simple
channel to softint packet processing on receive any time soon.

Going all the way to the socket is a large endeavor and will require a
lot of restructuring to do it right, so expect this to take on the
order of months.
