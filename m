Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUGET5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUGET5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUGET5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:57:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:56993 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261378AbUGET53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:57:29 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>
Subject: Re: 2.6.7-mm6 and usb deadlock (and synaptics)
Date: Mon, 5 Jul 2004 22:06:35 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040705131002.GA14768@gamma.logic.tuwien.ac.at> <20040705123243.7527e923.akpm@osdl.org>
In-Reply-To: <20040705123243.7527e923.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407052206.35692.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of July 2004 21:32, Andrew Morton wrote:
> Norbert Preining <preining@logic.at> wrote:
> > Hi Andrew!
> >
> > With 2.6.7-mm6 my laptop stops working completely. Ooops while booting.
> >
> > Reverting
> > - usb-locking-fix.patch
> > - bk-usb.patch
> > makes it work.

No USB problems here (dual Opteron w/ NUMA w/o preemption - hardware info 
attached).  I've checked both 1.1 (pendrive) and 2.0 (external HDD) and both 
work just fine.

I'm not sure, but it seems to me that the problems may be related to UHCI 
drivers (I have OHCI) - just guessing. :-)

Yours,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
