Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSHOCkD>; Wed, 14 Aug 2002 22:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSHOCkD>; Wed, 14 Aug 2002 22:40:03 -0400
Received: from imo-r04.mx.aol.com ([152.163.225.100]:27625 "EHLO
	imo-r04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S316500AbSHOCkD>; Wed, 14 Aug 2002 22:40:03 -0400
Message-ID: <3D5ADDDE.8010900@netscape.net>
Date: Wed, 14 Aug 2002 22:46:54 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: driverfs: [PATCH] remove bus and improve driver management (2.5.30)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mail program messed up the diagrams.  These should be better.
-Adam

bus->    pci->       parport_pc
             agpgart
             cardbus
             usb->       hid

driver->   pci->     usb->               hid
                              parport_pc->   lp
                              agpgart
                              cardbus

