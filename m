Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280691AbRKLNdG>; Mon, 12 Nov 2001 08:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279982AbRKLNc4>; Mon, 12 Nov 2001 08:32:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9997 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280691AbRKLNcl>; Mon, 12 Nov 2001 08:32:41 -0500
Subject: Re: 32-bit UID quotas?
To: clubneon@hereintown.net (Chris Meadors)
Date: Mon, 12 Nov 2001 13:39:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.40.0111120823210.88-100000@rc.priv.hereintown.net> from "Chris Meadors" at Nov 12, 2001 08:28:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163HJU-0005sY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I saw that ext3 is going into 2.4.15 by the testing/ChangeLog.  There are
> also lots of Alan Cox merging, but no specific mention of whether or not
> the 32-bit UID quota patch has gone in, or is going in.
> 
> The ext3 and 32-bit UID quotas were the only two patches I was really
> relying on the -ac releases for.

32bit uid quota is a harder one. Its probably something to be tackled after
2.4.15. There are a few other things like that which are lower priority 
because they are tricky, or because (eg the kiovec stuff) they are simply
performance boosts and can be done after we see 2.4.15 is solid

Other bits like the via timer fix are under further research

