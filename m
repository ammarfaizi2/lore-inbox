Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTICMKC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTICMKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:10:02 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:34251 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261969AbTICMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:10:00 -0400
Subject: Re: Scaling noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E19uQsT-0007mk-00@calista.inka.de>
References: <E19uQsT-0007mk-00@calista.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 13:09:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 07:12, Bernd Eckenfels wrote:
> Thats why NUMA gets so popular.

NUMA doesn't help you much.

> Larry, dont forget, that Linux is growing in the University Labs, where
> those big NUMA and Multi-Node Clusters are most popular for Number
> Crunching.

multi node yes, numa not much and where numa-like systems are being used
they are being used for message passing not as a fake big pc. 

Numa is valuable because
- It makes some things go faster without having to rewrite them
- It lets you partition a large box into several effective small ones 
  cutting maintenance
- It lets you partition a large box into several effective small ones
  so you can avoid buying two software licenses for expensive toys

if you actually care enough about performance to write the code to do
the job then its value is rather questionable. There are exceptions as
with anything else.


