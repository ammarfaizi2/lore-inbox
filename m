Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSIHWOY>; Sun, 8 Sep 2002 18:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSIHWOX>; Sun, 8 Sep 2002 18:14:23 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:12798 "HELO
	ip68-4-77-172.oc.oc.cox.net") by vger.kernel.org with SMTP
	id <S315413AbSIHWOX>; Sun, 8 Sep 2002 18:14:23 -0400
Date: Sun, 8 Sep 2002 15:19:05 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Adam Jaskiewicz <adamjaskie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Western Digital hard drive and DMA
Message-ID: <20020908221905.GA4731@ip68-4-77-172.oc.oc.cox.net>
References: <02090816463707.00459@aragorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02090816463707.00459@aragorn>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 04:46:37PM -0400, Adam Jaskiewicz wrote:
> OK, I have heard that other people have been having this problem for a while
> now, but I havent been able to find much about what causes it. I have a
> Western Digital hard drive in my computer (60GB, 5400 RPM) I can use it just
[snip]

What brand of IDE controller does your computer have? WD drives often
don't get along with VIA IDE controllers. (I think very recent WD drives
might have fixed this, but I'm not sure.)

Also, I'm pretty sure that a 60GB WD drive is too new to be affected by
the DMA problems that their older drives had. I'd look at other factors
like the cables (they are 80-conductor, and 18" or shorter, right?), the
IDE controller (bad controllers can do this), or the power supply (that
was the cause for the case of data corruption that I most recently
investigated).

-Barry K. Nathan <barryn@pobox.com>
