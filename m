Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTDVOdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTDVOdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:33:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1502
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263179AbTDVOdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:33:52 -0400
Subject: Re: 2.4.x high irq contention
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Anton Petrusevich <casus@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030422124042.200a3a60.skraw@ithnet.com>
References: <20030422033201.GA523@casus.home.my>
	 <20030422124042.200a3a60.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051019272.14881.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 14:47:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-22 at 11:40, Stephan von Krawczynski wrote:
> I don't know much about your network load, but if you have a lot, then you
> should probably throw away the 8139 network card and use tulip or 3com instead.

Won't help a lot. If its all IRQ load (eg lots of multicast streaming
audio small frames) then you want an eepro100 or something similar that
has interrupt mitigators.

