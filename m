Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSA2My7>; Tue, 29 Jan 2002 07:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSA2Myt>; Tue, 29 Jan 2002 07:54:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53010 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287841AbSA2Myg>; Tue, 29 Jan 2002 07:54:36 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 29 Jan 2002 13:06:09 +0000 (GMT)
Cc: landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <20020129005155.A6726@pimlott.ne.mediaone.net> from "Andrew Pimlott" at Jan 29, 2002 12:51:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VXxh-0003pj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> throughput is as high as he wants it to be!  Linus has pointed out
> more than once that a big part of his job is to limit change.  Maybe
> he's happy with the current rate of change in 2.5.  (That doesn't
> mean everything is optimal--he might wish for higher quality changes
> or a different mix of changes, just not more.)

Progress happens at its own rate. Linus can no more control rate of change
than you can put a waterfall into low gear. There is a difference between
refusing stuff where the quality is low and losing stuff which is clear
fixes

> Two, Linus has argued that maintainers are his patch penguins;
> whereas you favor a single integration point between the maintainers
> and Linus.  This has advantages and disadvantages, but on the whole,
> I think it is better if Linus works directly with subsystem

Perl I think very much shows otherwise. Right now we have a maze of partially 
integrated trees which overlap, clash when the people send stuff to Linus and
worse.

When you have one or two integrators you have a single tree pretty much everyone
builds new stuff from and which people maintain small diffs relative to. At
the end of the day that ends up like the older -ac tree, and with the same
conditions - notably that anything in it might be going to see /dev/null not
Linus if its shown to be flawed or not done well.

Alan
