Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSC1HAz>; Thu, 28 Mar 2002 02:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311960AbSC1HAq>; Thu, 28 Mar 2002 02:00:46 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:14982 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311948AbSC1HAd> convert rfc822-to-8bit; Thu, 28 Mar 2002 02:00:33 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: Steven Walter <srwalter@yahoo.com>, Berend De Schouwer <bds@jhb.ucs.co.za>
Subject: Re: VIA text console corruption and fix.
Date: Thu, 28 Mar 2002 09:03:37 +0100
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1017256651.18224.40.camel@bds.ucs.co.za> <20020327225549.GA5337@hapablap.dyn.dhs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200203280903.37096.linux.johnny@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. März 2002 23:55 schrieb Steven Walter:
> On Wed, Mar 27, 2002 at 09:17:30PM +0200, Berend De Schouwer wrote:
> [...]
>
> > I have 3000+ identical VIA KT133/Duron 750MHz machines.  In 20% of these
> > the bug is visible, in the others, it isn't.  The machines run in an
> > LTSP-ish configuration.  The machines are supposed to be identical (they
> > were bought together), but have different revisions of BIOS versions,
> > etc.  They have on-board S3 Savage cards that steal RAM from the main
> > RAM.
>
> Aha, another.  You're the fourth or fifth person with this problem.  I
> have a patch very similar to yours.  What my patch does is only clear
> bit 7, which is what was experimentally determined to disable the Write
> Memory Queue.  So far it seems that only KM133 (KT133 w/onboard S3
> Savage) are afflicted.
Well, I had a corrupted screen [unreadable characters], after running KDE rc3 for a few hours. Seems like the console font has been corrupted.
>
> However, the patch isn't being accepted until an explanation from VIA is
> obtained (apparently the head kernel honcho's were explicitly told to
> clear bit 5).  I'm working on that now.

