Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTALXIx>; Sun, 12 Jan 2003 18:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267616AbTALXIf>; Sun, 12 Jan 2003 18:08:35 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:33231 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267595AbTALXHx> convert rfc822-to-8bit; Sun, 12 Jan 2003 18:07:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net
Subject: Re: any chance of 2.6.0-test*?
Date: Mon, 13 Jan 2003 00:16:20 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <200301122343.41150.oliver@neukum.name> <1042411916.1209.181.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042411916.1209.181.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301130016.20595.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Januar 2003 23:51 schrieb Rob Wilkens:
> On Sun, 2003-01-12 at 17:43, Oliver Neukum wrote:
> > It's code that causes added hardship for anybody checking the locking.
>
> I can certainly see where it would seem "easier" to match "one lock" to
> "one unlock" if your troubleshooting a locking issue.
>
> "easier" is the motivation behind using goto.. Laziness.. that's all it
> is.

Yes, exactly. Lazyness is good. Any second spend on hitting Ctrl+F
and typing in the name of a cleanup function is lost. Any time
you overlook something because the cleanup and the code are
not on the same screen is a bug that is overlooked.
Any time one of the cleanup functions is overlooked can cause
hours lost in debugging after a change.

	Oliver

