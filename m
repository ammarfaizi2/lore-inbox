Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVIKSsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVIKSsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVIKSsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:48:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6379
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965027AbVIKSsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:48:13 -0400
Date: Sun, 11 Sep 2005 11:48:07 -0700 (PDT)
Message-Id: <20050911.114807.124745035.davem@davemloft.net>
To: maillist@jg555.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43245C56.5000905@jg555.com>
References: <43228E4E.4050103@jg555.com>
	<20050910.010114.28468998.davem@davemloft.net>
	<43245C56.5000905@jg555.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Sun, 11 Sep 2005 09:33:26 -0700

> David S. Miller wrote:
> 
> >You can make SILO 64-bit, but it would just be a lot
> >of work and would just result in a SILO that, unlike
> >current SILO, would only work on UltraSPARC machines.
> >
> >There really is no advantage, and known disadvantages, to
> >making SILO 64-bit.
> >  
>
> If I have a system that is a Pure64 environment, I try to compile Silo, 
> it will not function. Since there is no support for 32 bit, how would I 
> be able to use it.

You'll need some minimal 32-bit libraries sitting around in order
to build it, sorry.

For performance reasons alone I would _never_ condone a purely
64-bit userland.  It's simply a total lose from a performance
perspective, unlike some other platforms such as amd64 which
eradicate most of the 64-bit performance loss due to the gain
in available cpu registers compared to 32-bit x86.
