Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTFCU5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTFCU5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:57:32 -0400
Received: from gw.netgem.com ([195.68.2.34]:40715 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S261280AbTFCU5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:57:30 -0400
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
From: Jocelyn Mayer <jma@netgem.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603132504.C21083@one-eyed-alien.net>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
	 <20030602163443.2bd531fb.georgn@somanetworks.com>
	 <1054588832.4967.77.camel@jma1.dev.netgem.com>
	 <20030603113636.GX10102@phunnypharm.org>
	 <1054663917.4967.99.camel@jma1.dev.netgem.com>
	 <20030603185421.GB10102@phunnypharm.org>
	 <1054671619.4951.139.camel@jma1.dev.netgem.com>
	 <20030603132504.C21083@one-eyed-alien.net>
Content-Type: text/plain
Organization: 
Message-Id: <1054674754.4951.184.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jun 2003 23:12:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 22:25, Matthew Dharm wrote:
> I know jumping in the middle of a conversation is bad, but....
> 
> In conversations with the SBP2 folks, they indicated to me that the way
> they do hotplugging is very different from the way usb-storage does it.
> The end result (I'm told) is that invoking a scan from userspace is often
> needed for SBP2 but never for usb-storage.
> 
> So, comparing the two is really pointless.
> 
> Matt
> 

Hi,

you're right, I just wanted to point that there's no reason
that we need to register a device etheir by hand or using
an "infamous script" (citation from Ben Collins
http://sourceforge.net/mailarchive/message.php?msg_id=4435485 )
due to the SCSI stack, but that it's only a SBP2 problem.

Regards.


