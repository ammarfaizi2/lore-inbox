Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129515AbQKGSvf>; Tue, 7 Nov 2000 13:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129544AbQKGSvZ>; Tue, 7 Nov 2000 13:51:25 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:62456 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129515AbQKGSvK>;
	Tue, 7 Nov 2000 13:51:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC56@orsmsx31.jf.intel.com> 
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC56@orsmsx31.jf.intel.com> 
To: "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: "'Russell King'" <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: USB init order dependencies. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 18:50:50 +0000
Message-ID: <17072.973623050@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


randy.dunlap@intel.com said:
>  Yes, your proposal is to init only "usbcore" from init/main.c. I
> still don't see a need to do this in test10. It's fixed now AFAIK.

Not my proposal. The proposal to which Russell was objecting. 

My proposal was to just make the thing work without having to care about 
the link order.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
