Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWI2Hre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWI2Hre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWI2Hre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:47:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19614 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965062AbWI2Hrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:47:33 -0400
Message-ID: <451CCF8C.1000504@pobox.com>
Date: Fri, 29 Sep 2006 03:47:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
CC: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>	 <1157962200.10526.10.camel@localhost.localdomain>	 <1158051351.14448.97.camel@localhost.localdomain>	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com>	 <1158749825.7973.9.camel@localhost.localdomain>	 <45121924.4000200@pobox.com> <1159515406.13634.2.camel@localhost.localdomain>
In-Reply-To: <1159515406.13634.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zang Roy-r61911 wrote:
> Could you interpret the chip structure in more detail?
> Need I create two net_device struct for each port?

No.  One net_device per port.  And one container structure for the 
entire device.

	Jeff


