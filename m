Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUCPW2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUCPW2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:28:44 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:16886 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261766AbUCPW2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:28:40 -0500
Date: Tue, 16 Mar 2004 23:24:13 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: Re: Bug in ForeRunner LE (cache line settings) (was ATM (LANE) -
 related Kernel-Crashes)
In-Reply-To: <200403161749.i2GHnUe8013149@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.30.0403162025460.17727-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Mar 2004, chas williams (contractor) wrote:

> while i was looking at the bug report on the sourceforge site, i decided
> to take a quick look at your nicstar problem.  can you try the following
> patch (apply with patch -p1).

I applied your patch. The machine I checked (HP NetServer LC3, Pentium II)
now prints:
  nicstar0: PCI cache line size set incorrectly (0),
  setting cache line size to 8
when initializing the card.

Unfortunately, the patch does not fix the problem: My usual test
case, transferring data from Mcafee's ftp server, still doesn't
work.

Regards,
                Peter Daum

