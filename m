Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTFLTSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTFLTSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:18:13 -0400
Received: from gw.netgem.com ([195.68.2.34]:27664 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S264952AbTFLTSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:18:12 -0400
Subject: Re: lockup on USB event kernel 2.4.20
From: Jocelyn Mayer <jma@netgem.com>
To: denebeim@deepthot.org
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055446401.4948.408.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Jun 2003 21:33:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> My SO's computer works fine under redhat 8 which runs on a 2.4.18
> kernel, however on redhat 9 with a 2.4.20 kernel it locks up.  Also,
> redhat upgraded their kernel to 2.4.20 for rh 8 as well and I saw the
> same behavior.
> 
> Everything works fine until she moves her mouse which is connected to
> the USB, that locks the system.
> 
> Is this a known problem?  Any idea how I can debug it?
> 
> Thanks
> Jay
Hi,

Is your controler a UHCI one ?
If yes, try to connect your mouse via a hub if it's directly
connected to your computer.
There seem to be an issue with (rare) devices connected directly
to UHCI controlers.
I can easily lock UHCI based computers with an ATMEL Wifi device this way.

Regards.
-- 
Jocelyn Mayer <jma@netgem.com>

