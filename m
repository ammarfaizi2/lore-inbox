Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTDVRiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTDVRiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:38:09 -0400
Received: from mail.ithnet.com ([217.64.64.8]:48647 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263301AbTDVRiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:38:08 -0400
Date: Tue, 22 Apr 2003 19:50:03 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: casus@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x high irq contention
Message-Id: <20030422195003.30b6177f.skraw@ithnet.com>
In-Reply-To: <1051019272.14881.0.camel@dhcp22.swansea.linux.org.uk>
References: <20030422033201.GA523@casus.home.my>
	<20030422124042.200a3a60.skraw@ithnet.com>
	<1051019272.14881.0.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2003 14:47:53 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-04-22 at 11:40, Stephan von Krawczynski wrote:
> > I don't know much about your network load, but if you have a lot, then you
> > should probably throw away the 8139 network card and use tulip or 3com
> > instead.
> 
> Won't help a lot. If its all IRQ load (eg lots of multicast streaming
> audio small frames) then you want an eepro100 or something similar that
> has interrupt mitigators.

Well, handwaving about the network load/type ;-)
Could as well be two RTL back-to-back, normal packets but high bandwidth. 
(watch collisions for this case :-)

Regards,
Stephan

