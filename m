Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVDKRXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVDKRXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDKRW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:22:59 -0400
Received: from merke.itea.ntnu.no ([129.241.7.61]:51855 "EHLO
	merke.itea.ntnu.no") by vger.kernel.org with ESMTP id S261852AbVDKRWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:22:47 -0400
From: Per Christian Henden <perchrh@pvv.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add Mac mini sound support
Date: Mon, 11 Apr 2005 19:12:56 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200504091351.27430.perchrh@pvv.org> <1113089313.9568.435.camel@gaston>
In-Reply-To: <1113089313.9568.435.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111912.56648.perchrh@pvv.org>
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 April 2005 01:28, Benjamin Herrenschmidt wrote:
> On Sat, 2005-04-09 at 13:51 +0200, Per Christian Henden wrote:
> > The patch below adds sound support on the Mac Mini by making a small 
change to the PowerMac sound card detection code.
[Snip, details]
> And is not correct. It might appear to work but it is not the right
> thing to do. There is no AWACS chip in there. There is a fixed function
> codec controlled by a couple of GPIOs afaik. I'm working on a major
> rework of the alsa driver that will include support for the mini and the
> G5s.

Ok. It /does/ work, I've been using the AWACS driver for weeks now, and I 
don't have any stability or audio issues (that I notice), and my Mini is on 
24/7.

People that want sound support on their Minis right away can use this patch 
while waiting for the rework of the drivers, without fear of their computer 
exploding or so.

Cheers, 

PER
