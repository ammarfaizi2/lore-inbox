Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRABBsU>; Mon, 1 Jan 2001 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbRABBsL>; Mon, 1 Jan 2001 20:48:11 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:60422
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S129798AbRABBsA>; Mon, 1 Jan 2001 20:48:00 -0500
Date: Mon, 1 Jan 2001 20:17:33 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-testX fails to compile on my Athlon
Message-ID: <20010101201733.A11244@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0101011442440.1780-100000@po.teletubbies.dhs.org> you write:
> well.. silly me :)... I did have SMP enabled (it appears that's the
> default option? but anyways...now I get a whole slew of other
> errors.... which I'm not going to go into right now, cos that would
> involve spamming everyone with about 4 pages of spam

Did you do a "make mrproper" after changing to UP (be sure to save
your .config first, though)?  I've had trouble in the past where not
everything that needs to get regenerated does.

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
