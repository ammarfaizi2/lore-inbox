Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWDEAbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWDEAbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWDEAbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:31:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32462
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750890AbWDEAbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:31:47 -0400
Date: Tue, 04 Apr 2006 17:17:39 -0700 (PDT)
Message-Id: <20060404.171739.92845421.davem@davemloft.net>
To: rdreier@cisco.com
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       openib-general@openib.org, bunk@stusta.de, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mst@mellanox.co.il,
       rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to
 neigh_param
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adar74cnajg.fsf@cisco.com>
References: <20060405000030.GL27049@kroah.com>
	<20060404.170720.61536177.davem@davemloft.net>
	<adar74cnajg.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 04 Apr 2006 17:14:27 -0700

> I'm not going to fight too hard for it (I'll let Michael champion it
> if he really cares), but I think this is a legitimate -stable patch:
> it fixes a panic that real users are seeing.

You were using an interface in an unintended way.

Do you know %100 for certain that moving that callback to
a different location won't break anything?
