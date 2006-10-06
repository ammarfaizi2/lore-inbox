Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWJFJ0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWJFJ0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWJFJ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:26:36 -0400
Received: from mout2.freenet.de ([194.97.50.155]:52176 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932134AbWJFJ0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:26:35 -0400
To: "Peter Osterlund" <petero2@telia.com>
From: balagi@justmail.de
Subject: Re: Re: [PATCH 3/11] 2.6.18-mm3 pktcdvd: new pkt_find_dev()
Cc: linux-kernel@vger.kernel.org
X-Priority: 3
X-Abuse: 300631278 / unknown, unknown
User-Agent: freenetMail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1GVlyT-0006mx-SB@www12.emo.freenet-rz.de>
Date: Fri, 06 Oct 2006 11:26:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the idea was to simply allow
  map block-dev-id to pktcdvd
and
  unmap block-dev-id from pktcdvd
since this functionality can be implemented easily without costs in pkt_remove_dev()

But it is ok to put it into user space.

-Thomas Maier

----- original Nachricht --------

Betreff: Re: [PATCH 3/11] 2.6.18-mm3 pktcdvd: new pkt_find_dev()
Gesendet: Do 05 Okt 2006 21:51:43 CEST
Von: "Peter Osterlund"<petero2@telia.com>

> "Thomas Maier" <balagi@justmail.de> writes:
> 
> > Also pkt_remove_dev() can use now the device id of the mapped
> > block device to remove the mapping.
> 
> Why would that be desirable? I think it's better to implement this
> feature in the user space tools and leave the kernel interface
> simple.
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://web.telia.com/~u89404340
> 

--- original Nachricht Ende ----









