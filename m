Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVBKMWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVBKMWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 07:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVBKMWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 07:22:10 -0500
Received: from B3114.karlshof.wh.tu-darmstadt.de ([130.83.219.14]:35486 "HELO
	B3114.karlshof.wh.tu-darmstadt.de") by vger.kernel.org with SMTP
	id S262126AbVBKMWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 07:22:07 -0500
Subject: Re: DVB at76c651.c driver seems to be dead code
From: Andreas Oberritter <obi@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mws <mws@twisted-brains.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050211094934.GO2958@stusta.de>
References: <20050210235605.GN2958@stusta.de>
	 <200502110211.29055.mws@twisted-brains.org>
	 <20050211094934.GO2958@stusta.de>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 13:23:24 +0100
Message-Id: <1108124605.3535.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 10:49 +0100, Adrian Bunk wrote:
> If I understand it correctly, there are several drivers that only make 
> sense if they are used together. at76c651.c alone makes zero sense?
> This means it would be highly appreciated to have all parts inside the 
> kernel at some time in the future.

It makes sense if
- the dbox2 core code gets merged into mainline, which is our goal, but
  can take a huge amount of time.
- someone rips off the frontend module of a dbox2 and puts it on his
  PCI DVB card because this Atmel chip rocks so much :-)
  It will require only very few changes to the PCI driver...
- or a company decides to use this chip on their brand new DVB-C device
  and john doe decides to write a Linux driver for it. He will then
  notice that there is already a driver for the frontend module and can
  therefore save a lot of work.

> Something different:
> The atmel at76c651 frontend driver is specific to the MPC823 
> architecture?

no.

Regards,
Andreas

