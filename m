Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbTF3WYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbTF3WYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:24:44 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:40977 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S265935AbTF3WYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:24:42 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
Date: Mon, 30 Jun 2003 22:39:03 +0000 (UTC)
Organization: Cistron
Message-ID: <bdqe67$bgp$1@news.cistron.nl>
References: <20030630221542.GA17416@alf.amelek.gda.pl>
X-Trace: ncc1701.cistron.net 1057012743 11801 62.216.30.38 (30 Jun 2003 22:39:03 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Michalkiewicz  <marekm@amelek.gda.pl> wrote:
>I don't remember seeing anything like that in any earlier 2.4.x
>kernels.  Is this a known problem?  Is this anything dangerous -
>should I disable UDMA for now to play it safe?

afaik this concerns a "lost" interrupt.
Alan Cox's -ax__ pre-patches (current ac4) seems to fix it 
for a lot of people. Other approch is to disable IO_APIC on
uni processors during kernel compile.

Happy compiling ;-)

Danny

-- 
Miguel   | "I can't tell if I have worked all my life or if
de Icaza |  I have never worked a single day of my life,"

