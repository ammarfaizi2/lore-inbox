Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRJAQJv>; Mon, 1 Oct 2001 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275198AbRJAQJl>; Mon, 1 Oct 2001 12:09:41 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:15588 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S275098AbRJAQJX>;
	Mon, 1 Oct 2001 12:09:23 -0400
Date: Mon, 1 Oct 2001 18:09:46 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ethX <-> module matching from userspace?
In-Reply-To: <Pine.LNX.4.10.10110011149110.13303-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.GSO.4.30.0110011807420.9614-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a way that i could get which module registered which ethX
> > interface, from userspace? I would really like to see it.
>
> grep eth0 /var/log/messages | tail -1
> ?

Well, err... First i dont want to rely on syslog, secondly it is _not_
reliably for this case because every module sends different kind of output
to the syslog, and a bunch of them don't even tell the name of itself (for
example 3c59x).

-- 


