Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262255AbSIZJHC>; Thu, 26 Sep 2002 05:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262254AbSIZJHC>; Thu, 26 Sep 2002 05:07:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5253 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262255AbSIZJHC>;
	Thu, 26 Sep 2002 05:07:02 -0400
Date: Thu, 26 Sep 2002 02:06:02 -0700 (PDT)
Message-Id: <20020926.020602.75761707.davem@redhat.com>
To: ratz@drugphish.ch
Cc: ak@suse.de, niv@us.ibm.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D92CCC5.5000206@drugphish.ch>
References: <p73n0q5sib2.fsf@oldwotan.suse.de>
	<20020925.172931.115908839.davem@redhat.com>
	<3D92CCC5.5000206@drugphish.ch>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roberto Nibali <ratz@drugphish.ch>
   Date: Thu, 26 Sep 2002 11:00:53 +0200

   Hello DaveM and others,
   
   > That's the second level cache, not the top level lookup which
   > is what hits %99 of the time.
 ...   
   the L2 cache was the limiting factor

I'm not talking about cpu second level cache, I'm talking about
a second level lookup table that backs up a front end routing
hash.  A software data structure.

You are talking about a lot of independant things, but I'm going
to defer my contributions until we have actual code people can
start plugging netfilter into if they want.

About using syslog to record messages, that is doomed to failure,
implement log messages via netlink and use that to log the events
instead.
