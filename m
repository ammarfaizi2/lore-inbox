Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTC0RKO>; Thu, 27 Mar 2003 12:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTC0RJZ>; Thu, 27 Mar 2003 12:09:25 -0500
Received: from dsl-213-023-212-049.arcor-ip.net ([213.23.212.49]:32131 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S263317AbTC0RIf> convert rfc822-to-8bit; Thu, 27 Mar 2003 12:08:35 -0500
From: Dominik Kubla <dominik@kubla.de>
To: Chris Wedgwood <cw@f00f.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Date: Thu, 27 Mar 2003 18:19:41 +0100
User-Agent: KMail/1.5.1
References: <20030324212813.GA6310@osiris.silug.org> <20030327160220.GA29195@work.bitmover.com> <20030327170039.GA26452@f00f.org>
In-Reply-To: <20030327170039.GA26452@f00f.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303271819.41971.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 27. März 2003 18:00 schrieb Chris Wedgwood:

> > Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
> > slovax kernel: Bank 1: 9000000000000151
>
> Status: (9000000000000151) Restart IP valid.
>
> *Exactly* what this means I don't know --- but I'm guessing the CPU is
> overheating.  Check fans, air-flow, etc. and see if that helps.  So
> far whenever I've seen the above problem it's *ALWAYS* been related to
> the CPU getting too hot.

Well the internal busses and buffers of modern CPU's and in many cases also 
the on-die caches have ECC logic.  And if i should hazard a guess: "Restart 
IP valid" => Restarted Instruction Pre-Fetch resulted in a valid state of the 
pre-fetch queue.

In Larry's case i'd remove the cpu cooler, clean everything and reassemble, 
since i would assume that there is a hot-spot on the die.

Regards,
  Dominik
-- 
Be at war with your voices, at peace with your neighbors, and let every new
year find you a better man. (Benjamin Franklin, 1706-1790)

